#!/usr/bin/sh
#
cd /home/NCOR6649/scripts/alcatel/cell

touch /home/NCOR6649/logs/cell/taskdata/nwd_bsc_bts_cell

echo "Huawei-OMC-3"
ftp -n -p 10.231.170.70 <<EOF
user ftpuser ftpuser

cd /export/home/noccord/logs/
hash
bin
mget hu_cell.txt



bye
EOF

#cat hu_cell.txt  |  nawk ' FS="|" ,OFS="|" { split($7,lac,"(");split(lac[2],lac_f,")");split($8,cellid,"(");split(cellid[2],cellid_f,")");print "Huawei","homc3",$1,$32,$3,$31,lac_f[1],cellid_f[1] } ' >> /home/NCOR6649/logs/cell/taskdata/nwd_bsc_bts_cell
cat hu_hom2_cell.txt | nawk ' FS="|" ,OFS="|" { split($7,lac,"(");split(lac[2],lac_f,")");split($8,cellid,"(");split(cellid[2],cellid_f,")");print "Huawei","homc2",$1,substr($3,1,3)""substr($3,5,length($3)),$3,$2,lac_f[1],cellid_f[1] } '  >> /home/NCOR6649/logs/cell/taskdata/nwd_bsc_bts_cell



echo "-----------------------------------------------------------"
echo ""
echo "Huawei-OMC-4"
ftp -n -p 10.231.170.104 <<EOF
user ftpatae Ftpat@e1 
dir /export/home/ftpatae/noccord/logs/hu_cell.txt
cd  /export/home/ftpatae/noccord/logs/ 
hash
bin
mget hu_cell.txt

bye
EOF


#cat hu_cell.txt  |  nawk ' FS="|" ,OFS="|" { split($7,lac,"(");split(lac[2],lac_f,")");split($8,cellid,"(");split(cellid[2],cellid_f,")");print "Huawei","homc3",$1,$32,$3,$31,lac_f[1],cellid_f[1] } ' >> /home/NCOR6649/logs/cell/taskdata/nwd_bsc_bts_cell
cat hu_hom2_cell.txt | nawk ' FS="|" ,OFS="|" { split($7,lac,"(");split(lac[2],lac_f,")");split($8,cellid,"(");split(cellid[2],cellid_f,")");print "Huawei","homc2",$1,substr($3,1,3)""substr($3,5,length($3)),$3,$2,lac_f[1],cellid_f[1] } '  >> /home/NCOR6649/logs/cell/taskdata/nwd_bsc_bts_cell