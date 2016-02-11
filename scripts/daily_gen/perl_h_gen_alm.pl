# use strict;

# use Warnings;
 
use Time::localtime;
use Time::Local;
use POSIX qw(strftime);
my $tm = localtime;

my $pt=localtime(time-86400) ;



my $TIME = timelocal($tm->sec, $tm->min, $tm->hour, $tm->mday, $tm->mon, $tm->year);
my $PTIME = timelocal($pt->sec, $pt->min, $pt->hour, $pt->mday, $pt->mon, $pt->year);

# print $tm->mday;

# $TIME = $TIME - 7 * 24 * 60 * 60;

$tm = localtime($TIME);
# printf("7 Days back  : %04d-%02d-%02d => %02d:%02d:%02d\n", 
#                  $tm->year+1900,$tm->mon+1, $tm->mday, 
#                  $tm->hour, $tm->min, $tm->sec);


#my $ATIME = timelocal("34", "12","12","11","11","2011");

# print "YEAR",$ATIME ;


while(<>) {



    ($Fld1,$Fld2,$Fld3,$Fld4,$Fld5,$Fld6,$Fld7,$Fld8,$Fld9,$Fld10,$Fld11,$Fld12,$Fld13) = split(/[|\n]/, $_ );
   
     #print "$Fld1|$Fld2|$Fld3\n" ;
      $f1=length($Fld3);
  
 
    
    @dat = split(' ', $Fld3);
    @dd=split('/',$dat[0]);
    @tt=split(':',$dat[1]);


        $ATIME = timelocal($tt[2],$tt[1],$tt[0],$dd[1],$dd[0]-1,$dd[2]-1900) ;

      $d=$dd[1] ;
      $m=$dd[0] ;
      $y=$dd[2] ;
        my $xmas_time = timelocal(0,0,0,$d,$m-1,$y);
        my $today = time;
         $diff_oc = int( ($today - $xmas_time) / (24*60*60) )-1 ;
        
     #    print "Difference is $diff_oc days\n";



       if($diff_oc > 0 ) {
            
        # print "=-=-=-=-" ;
          
            $ATIME = timelocal(0,0,0,$pt->mday,($pt->mon),($pt->year) ) ; 

         $tm = localtime($ATIME);

      $Fld3 = strftime ( "%m/%d/%Y %H:%M:%S", $tm->sec, $tm->min, $tm->hour, $tm->mday, $tm->mon, $tm->year) ;


       
         

            $ATIME = timelocal(59,59,23,$pt->mday,($pt->mon),($pt->year) ) ; 


         $tm = localtime($ATIME);

      $Fld4 = strftime ( "%m/%d/%Y %H:%M:%S", $tm->sec, $tm->min, $tm->hour, $tm->mday, $tm->mon, $tm->year) ;

     print "$Fld1|$Fld2|$Fld3|$Fld4\n"
      
     }
 
}
