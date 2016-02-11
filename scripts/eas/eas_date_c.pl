# use strict;

# use Warnings;
 
use Time::localtime;
use Time::Local;
use POSIX qw(strftime);
my $tm = localtime;
#print $tm->year;
#printf("Current Time : %04d-%02d-%02d => %02d:%02d:%02d\n", 
#                  $tm->year+1900,$tm->mon+1, $tm->mday, 
#                  $tm->hour, $tm->min, $tm->sec);

my $TIME = timelocal($tm->sec, $tm->min, $tm->hour, $tm->mday, $tm->mon, $tm->year);

# print $TIME;

$TIME = $TIME - 7 * 24 * 60 * 60;

$tm = localtime($TIME);
# printf("7 Days back  : %04d-%02d-%02d => %02d:%02d:%02d\n", 
#                  $tm->year+1900,$tm->mon+1, $tm->mday, 
#                  $tm->hour, $tm->min, $tm->sec);


my $ATIME = timelocal("34", "12","12","11","11","2011");

# print "YEAR",$ATIME ;


while(<>) {

    ($Fld1,$Fld2,$Fld3,$Fld4,$Fld5,$Fld6,$Fld7,$Fld8,$Fld9,$Fld10,$Fld11,$Fld12,$Fld13) = split(/[|\n]/, $_ );
   

    @dat = split(' ', $Fld3);
    @dd=split('/',$dat[0]);
    @tt=split(':',$dat[1]);

    #  if (int($tt[2])>59){ $tt[2]=59 ; } ;
    
        $ATIME = timelocal($tt[2],$tt[1],$tt[0],$dd[1],$dd[0]-1,$dd[2]-1900) ;

        $ATIME = $ATIME + (5 * 60 * 60);

         $tm = localtime($ATIME);

      $Fld3 = strftime ( "%m/%d/%y %H:%M:%S", $tm->sec, $tm->min, $tm->hour, $tm->mday, $tm->mon, $tm->year) ;

     @dat = split(' ', $Fld4);
    @dd=split('/',$dat[0]);
    @tt=split(':',$dat[1]);

    #  if (int($tt[2])>59){ $tt[2]=59 ; } ;
   
        $ATIME = timelocal($tt[2],$tt[1],$tt[0],$dd[1],$dd[0]-1,$dd[2]-1900) ;

        $ATIME = $ATIME + (5 * 60 * 60);

         $tm = localtime($ATIME);

      $Fld4 = strftime ( "%m/%d/%y %H:%M:%S", $tm->sec, $tm->min, $tm->hour, $tm->mday, $tm->mon, $tm->year) ;

 

    

      
      print "$Fld1|$Fld2|$Fld3|$Fld4|$Fld5\n";

 
   
 

}
