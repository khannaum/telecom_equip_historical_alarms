#cat reportstorage.sh
#!/bin/sh
#set -x
# -----------------------------------------------
# Gets storage report for manager's name
# -----------------------------------------------

# configuration file
global_infile=storage.conf

# prepare input file, ignore comments and blank lines, uniq (maybe duplicated entries), sort
cat ${global_infile} | sed -e '/^#/d' -e '/^$/d' | sort | uniq > ${global_infile}.$$

# separate input temporary file for ufs/zfs
ufs_infile=ufs_infile.$$
zfs_infile=zfs_infile.$$
cat ${global_infile}.$$ | awk -F: '$4=="ufs"' > ${ufs_infile}
cat ${global_infile}.$$ | awk -F: '$4=="zfs"' > ${zfs_infile}


# ---------------------------------
# functions
# -------------------------------

# --- FUNCTION: process hosts with ufs/metadevices
process_ufs() {

        # get list of hosts that has metadevices
        ufs_hostlist=`cat ${ufs_infile} | awk -F: '{print $1}' | sort | uniq`

        # process host
        for ufs_host in ${ufs_hostlist}
        do

                fping -q ${ufs_host} #-q=quite
                if [ $? -eq 0 ]
                then

                        # for system in the loop, get mount point of metadevice, from ${ufs_infile}
                        metadevice=`cat ${ufs_infile} | awk -F: '$1=="'${ufs_host}'" {print $2}'`

                        # process all metadevices in a system
                        for md in ${metadevice}
                        do

                                # find mount point of metadevice
                                mount=`ssh ${ufs_host} mount | gegrep -w  "/dev/md/dsk/${md}" | awk '{print $1}'`

                                # find total size of md
                                usable=`ssh ${ufs_host} df -k ${mount} | gegrep -v "^Filesystem" | awk '{print $2}'` # total

                                # find used size of md
                                alocated=`ssh ${ufs_host} df -k ${mount} | gegrep -v "^Filesystem" | awk '{print $3}'` #used

                                # from ${ufs_infile} get description of metadevice
                                ufs_desc=`cat ${ufs_infile} | awk -F: '$1=="'${ufs_host}'" && $2=="'${md}'" {print $3}'`

                                # screen output FYI
                                printf "%-20s %-20s %-20s %-20s %-20s \n" \
                                "Host:${ufs_host}" "Mount:${mount}" " Desc:${ufs_desc}" \
                                "Total[KB]=${usable}" "Used[KB]=${alocated}"

                                # feed tmp file for further processing
                                echo ${ufs_desc} >> ufs_desc.$$
                                echo "${ufs_desc} ${usable} ${alocated}" >> ufs_of.$$

                        done
                else
                        echo "Host ${ufs_host} is not reachable."
                fi

        done
}

# --- FUNCTION: process hosts with zfs
process_zfs() {

        # get list of hosts that has zfs
        zfs_hostlist=`cat ${zfs_infile} | awk -F: '{print $1}' | sort | uniq`

        # process host
        for zfs_host in ${zfs_hostlist}
        do

                fping -q ${zfs_host} #-q=quite
                if [ $? -eq 0 ]
                then

                        # for system in the loop, get zfs, from ${zfs_infile}
                        zetafs=`cat ${zfs_infile} | awk -F: '$1=="'${zfs_host}'" {print $2}'`

                        # process all zfs in a system
                        for zfs in ${zetafs}
                        do

                                # find used, avail, total size of zfs
                                used=`ssh ${zfs_host} zfs get -H -p used ${zfs} | awk '{print $3}'` # allocated in bytes
                                avail=`ssh ${zfs_host} zfs get -H -p avail ${zfs} | awk '{print $3}'` # free in bytes
                                total=`(echo "${used}+${avail}" | bc -l)` # total in bytes

                                # from ${zfs_infile} get description of zfs
                                zfs_desc=`cat ${zfs_infile} | awk -F: '$1=="'${zfs_host}'" && $2=="'${zfs}'" {print $3}'`

                                # screen output FYI
                                printf "%-20s %-20s %-20s %-20s %-20s \n" \
                                "Host:${zfs_host}" "ZFS:${zfs}" " Desc:${zfs_desc}" "Total[B]:${total}" "Used[B]:${used}"

                                # feed tmp file for further processing
                                echo ${zfs_desc} >> zfs_desc.$$
                                echo "${zfs_desc} ${total} ${used}" >> zfs_of.$$
                        done
                else
                        echo "Host ${zfs_host} is not reachable."
                fi
        done
}

# --- FUNCTION: clean temp files
tmp_file_cleaning() {
        [ -f ${global_infile}.$$ ] && rm ${global_infile}.$$
        [ -f ${ufs_infile} ] && rm ${ufs_infile}
        [ -f ufs_desc.$$ ] && rm ufs_desc.$$
        [ -f ufs_of.$$ ] && rm ufs_of.$$
        [ -f ${zfs_infile} ] && rm ${zfs_infile}
        [ -f zfs_desc.$$ ] && rm zfs_desc.$$
        [ -f zfs_of.$$ ] && rm zfs_of.$$
}

# --- cleaning in case of script termination and regular exit
trap tmp_file_cleaning HUP INT QUIT ABRT EXIT

# Process UFS and ZFS
process_ufs ; process_zfs

# ----- LOOK FOR SAME DESCRIPTION AND SUM THEIR VALUES

# remove duplicated description from tmp file
cat ufs_desc.$$ | sort| uniq > ufs_desc.$$.tmp ; mv ufs_desc.$$.tmp ufs_desc.$$
cat zfs_desc.$$ | sort| uniq > zfs_desc.$$.tmp ; mv zfs_desc.$$.tmp zfs_desc.$$

# print title on screen FYI
printf "------------------------------------------------------------------------- \n"
printf "%-15s %15s %15s \n" "Description" "Usable/Total[GB]" "Allocated/Used[GB]"
printf "------------------------------------------------------------------------- \n"

# for each description, calculate sum values, print on screen
# UFS - received in KB
for description in `cat ufs_desc.$$`
do
        cat ufs_of.$$ | \
        awk '$1=="'${description}'" {sumusable+=$2; sumalocated+=$3} \
        END {printf "%-15s %11.0f %15.0f \n", "'${description}'", sumusable/1024/1024, sumalocated/1024/1024, "\n" }'
done
# ZFS - received in B
for description in `cat zfs_desc.$$`
do
        cat zfs_of.$$ | \
        awk '$1=="'${description}'" {sumusable+=$2; sumalocated+=$3} \
        END {printf "%-15s %11.0f %15.0f \n", "'${description}'", sumusable/1024/1024/1024, sumalocated/1024/1024/1024, "\n" }'
done

exit 0


