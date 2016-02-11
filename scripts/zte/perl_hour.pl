# use strict;

# use Warnings;
 # Initiate the time libraries
use Time::localtime;
use Time::Local;
use POSIX qw(strftime);
my $tm = localtime;

#my $pt=localtime(time-86400) ;

my @lines;
while( my $line = <>)  {
  # print $line;
       push @lines, $line;
}


for (my $n=3; $n >= 0; $n--) {
#print "=======$n\n";
my $pt=localtime(time-($n*24*60*60));
my $pt=localtime(time-($n*60));
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


#while(<>) {

foreach my $line(@lines)  {

   # ($Fld1,$Fld2,$Fld3,$Fld4) = split(/[|\n]/, $_ );
     ($Fld1,$Fld2,$Fld3,$Fld4,$Fld5) = split(/[|\n]/, $line );
    # print $line;
   # print "$Fld1|$Fld2|$Fld3|$Fld4|$Fld5\n" ;
      $f1=length($Fld3);
      $f2=length($Fld4);
   # print "$f1|$f2\n" ;
   
   if($f1 >1) { 
    @dat = split(' ', $Fld3);
    @dd=split('/',$dat[0]);
    @tt=split(':',$dat[1]);
    #print "$Fld3\n";
   # $dd[2]="20" . $dd[2];
        $ATIME = timelocal($tt[2],$tt[1],$tt[0],$dd[1],$dd[0]-1,$dd[2]-1900) ;

      $d=$dd[1] ;
      $mm=$dd[0] ;
      $y=$dd[2] ;
      $h=$tt[0];
      $m=$tt[1];
      $s=$tt[2];
        my $xmas_time = timelocal(0,0,0,$d,$mm-1,$y);
        my $xmas_time = timelocal($s,$m,$h,$d,$mm-1,$y);
        my $today = time;
       #  $diff_oc = int( ($today - $xmas_time) / (24*60*60) )-$n ;
          $diff_oc = int( ($today - $xmas_time) / ($n*60) )-$n ;
       # print "$n\n";
        # print "Difference is $diff_oc days\n";
    }


   if(($f2 >1)  ) {
    @datt = split(' ', $Fld4);
    @ddd=split('/',$datt[0]);
    @ttt=split(':',$datt[1]);
   # $ddd[2]="20" . $ddd[2];

        $ATIME = timelocal($ttt[2],$ttt[1],$ttt[0],$ddd[1],$ddd[0]-1,$ddd[2]-1900) ;

      $d=$ddd[1] ;
      $mm=$ddd[0] ;
      $y=$ddd[2] ;
      $h=$ttt[0];
      $m=$ttt[1];
      $s=$ttt[2];
        my $xmas_time = timelocal(0,0,0,$d,$mm-1,$y);
        my $xmas_time = timelocal($s,$m,$h,$d,$mm-1,$y);
        my $today = time;
       #  $diff_cl = int( ($today - $xmas_time) / (24*60*60) )-$n ;
         $diff_cl = int( ($today - $xmas_time) / ($n*60) )-$n ;
       # print $n;
         #print "Difference is $diff_cl days\n";
     }
   
  # print "$diff_oc","===","$diff_cl","\n" ;

       if($diff_oc > 0 ) {
           
          
            # $ATIME = timelocal(0,0,0,$pt->mday,($pt->mon),($pt->year) ) ; 
						$ATIME = timelocal(0,0,$n,$pt->mday,($pt->mon),($pt->year) ) ; 
         $tm = localtime($ATIME);

      $Fld3 = strftime ( "%m/%d/%Y %I:%M:%S %p", $tm->sec, $tm->min, $tm->hour, $tm->mday, $tm->mon, $tm->year) ;
      # print "====lll====" ; 

        }


       
       if($diff_cl < 0 || $f2 <1 ) {
       

            $ATIME = timelocal(59,59,23,$pt->mday,($pt->mon),($pt->year) ) ; 
            $ATIME = timelocal(59,59,$n,$pt->mday,($pt->mon),($pt->year) ) ; 

         $tm = localtime($ATIME);

      $Fld4 = strftime ( "%m/%d/%Y %I:%M:%S %p", $tm->sec, $tm->min, $tm->hour, $tm->mday, $tm->mon, $tm->year ) ;
      #   print "====lll====" ;
    }
 

    if( not(($diff_oc > 0) && ($diff_cl > 0) ) && not(($diff_oc < 0) && ($diff_cl < 0) )  ) {
     #if( not(($diff_oc > 0) && ($diff_cl > 0) ) ) {

 
      print "$Fld1|$Fld2|$Fld3|$Fld4|$Fld5\n";

       }   
 

}



}