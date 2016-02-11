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



    ($Fld1,$Fld2,$Fld3,$Fld4,$Fld6,$Fld7,$Fld8,$Fld9,$Fld10,$Fld11,$Fld12,$Fld13) = split(/[|\n]/, $_ );
   
  #   print "$Fld1|$Fld2|$Fld3|$Fld4|$Fld5\n" ;
      $f1=length($Fld3);
      $f2=length($Fld3);
   # print "$f1|$f2\n" ;
   
  
    @dat = split(' ', $Fld3);
    @dd=split('/',$dat[0]);
    @tt=split(':',$dat[1]);


        $ATIME = timelocal($tt[2],$tt[1],$tt[0],$dd[1],$dd[0]-1,$dd[2]-1900) ;

         $tm = localtime($ATIME);

      $Fld3 = strftime ( "%m/%d/%Y %I:%M:%S %p", $tm->sec, $tm->min, $tm->hour, $tm->mday, $tm->mon, $tm->year) ;


   
    @datt = split(' ', $Fld4);
    @ddd=split('/',$datt[0]);
    @ttt=split(':',$datt[1]);


        $BTIME = timelocal($ttt[2],$ttt[1],$ttt[0],$ddd[1],$ddd[0]-1,$ddd[2]-1900) ;

      
        


         $tm = localtime($BTIME);

      $Fld4 = strftime ( "%m/%d/%Y %I:%M:%S %p", $tm->sec, $tm->min, $tm->hour, $tm->mday, $tm->mon, $tm->year) ;
      #   print "====lll====" ;
    
        $a =  ($Fld4  - $Fld3 ) / (60) ;
     
     
      $dt = sprintf("%.2f",$a->minutes) ; 
      # (24*60)  ;
     
     print "$Fld2|$Fld3|$Fld4|$dt\n";
    #  print "$Fld1|$Fld2|$Fld3|$Fld4\n";
  
}
