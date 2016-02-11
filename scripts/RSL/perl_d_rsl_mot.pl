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
   
      # print "$Fld1|$Fld2|$Fld3|$Fld4|$Fld5|$Fld6\n" ;
      
      $f1=length($Fld4);
      $f2=length($Fld5);
   #  print "$f1|$f2\n" ;
        if($f1>20){ @gg=split(' ',$Fld5);$Fld4="$gg[0] 00:00:00" }
        if($f2<20){ @gg=split(' ',$Fld4);$Fld5="$gg[0] 23:59:59" } 
   if($f1 >1) { 
    @dat = split(' ', $Fld4);
    @dd=split('/',$dat[0]);
    @tt=split(':',$dat[1]);

   # $dd[2]="20" . $dd[2];
        $ATIME = timelocal($tt[2],$tt[1],$tt[0],$dd[1],$dd[0]-1,$dd[2]-1900) ;

      $d=$dd[1] ;
      $m=$dd[0] ;
      $y=$dd[2] ;
        my $xmas_time = timelocal(0,0,0,$d,$m-1,$y);
        my $today = time;
         $diff_oc = int( ($today - $xmas_time) / (24*60*60) )-1 ;
        
        # print "Difference is $diff_oc days\n";
    }


   if(($f2 >1)  ) {
    @datt = split(' ', $Fld5);
    @ddd=split('/',$datt[0]);
    @ttt=split(':',$datt[1]);
   # $ddd[2]="20" . $ddd[2];

        $ATIME = timelocal($ttt[2],$ttt[1],$ttt[0],$ddd[1],$ddd[0]-1,$ddd[2]-1900) ;

      $d=$ddd[1] ;
      $m=$ddd[0] ;
      $y=$ddd[2] ;
        my $xmas_time = timelocal(0,0,0,$d,$m-1,$y);
        my $today = time;
         $diff_cl = int( ($today - $xmas_time) / (24*60*60) )-1 ;
        
        # print "Difference is $diff_cl days\n";
     }
   
  # print "$diff_oc","===","$diff_cl","\n" ;

       if($diff_oc > 0 ) {
            
          
            $ATIME = timelocal(0,0,0,$pt->mday,($pt->mon),($pt->year) ) ; 

         $tm = localtime($ATIME);

      $Fld4 = strftime ( "%m/%d/%Y %H:%M:%S", $tm->sec, $tm->min, $tm->hour, $tm->mday, $tm->mon, $tm->year) ;
      # print "====lll====" ; 

        }


       
       if($diff_cl < 0 || $f2 <1 ) {
         

            $ATIME = timelocal(59,59,23,$pt->mday,($pt->mon),($pt->year) ) ; 


         $tm = localtime($ATIME);

      $Fld5 = strftime ( "%m/%d/%Y %H:%M:%S", $tm->sec, $tm->min, $tm->hour, $tm->mday, $tm->mon, $tm->year) ;
      #   print "====lll====" ;
    }
 

    
     if( not(($diff_oc > 0) && ($diff_cl > 0) ) ) {

      @dat = split(' ', $Fld4);
    @dd=split('/',$dat[0]);
    @tt=split(':',$dat[1]);

        $ATIME1 = timelocal($tt[2],$tt[1],$tt[0],$dd[1],$dd[0]-1,$dd[2]-1900) ;

@dat = split(' ', $Fld5);
    @dd=split('/',$dat[0]);
    @tt=split(':',$dat[1]);

        $ATIME2 = timelocal($tt[2],$tt[1],$tt[0],$dd[1],$dd[0]-1,$dd[2]-1900) ;

         # $diff_cl = int( ($today - $xmas_time) / (24*60*60) )-1 ;
         $diff_oc = ( ($ATIME2-$ATIME1)/ (24*60) )*24 ;
         $diff_oc = sprintf "%.4f",$diff_oc  ;

        # print "Difference is $diff_oc days\n";

 
      print "$Fld1|$Fld2|$Fld4|$Fld5\n";

       }   
 

}
