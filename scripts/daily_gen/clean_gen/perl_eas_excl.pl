#!/usr/bin/perl

#use strict;

#use Warnings;
 
use Time::localtime;
use Time::Local;

use POSIX qw(strftime);
use POSIX qw(mktime);
#use DateTime;

my $tm = localtime;

my $pt=localtime(time-86400) ;

open(A, ">tmpf");
open(B, ">tmpv");

my(@linea) = <A>; # read file into list
my(@lineb) = <B>; # read file into list


my($linef);
my($linev);

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
#print "Info: ARGV is: @ARGV\n";

while(<>){
   chomp;
        #next if /^\s*$/; # skip empty lines

    ($Fld1,$Fld2,$Fld3,$Fld4,$Fld5,$Fld6) = split(/[|\n]/, $_,99999);
    
     # next if /^\s*$$Fld3/; # skip empty lines
     # next if /^\s*$$Fld4/; # skip empty lines
    @dat = split(' ', $Fld3);
    @dd=split('/',$dat[0]);
    @tt=split(':',$dat[1]);
  #print "$dd[2]" ;
     $cl=length $dd[2];
  # print "$cl ";  
    if($cl<4){ $dd[2]="20" . $dd[2] ; };
      $ATIME = timelocal($tt[2],$tt[1],$tt[0],$dd[1],$dd[0]-1,$dd[2]-1900) ;
     
    @datt = split(' ', $Fld4);
    @ddd=split('/',$datt[0]);
    @ttt=split(':',$datt[1]);
   # $ddd[2]="20" . $ddd[2];
     
       $cl=length $ddd[2];
    if($cl<4){ $ddd[2]="20" . $ddd[2] ; };
       $BTIME = timelocal($ttt[2],$ttt[1],$ttt[0],$ddd[1],$ddd[0]-1,$ddd[2]-1900) ;
    
    
   
      $a =  int(($BTIME - $ATIME) / 60) ;
       $a =  (($BTIME - $ATIME) / 60) ;
      # print $a;
    if($a<0){ $a = ((360)*2)- (int(($ATIME - $BTIME) ) /60) } ;
     # if($a<0) { $a=1440+$a} ;
      $dt = sprintf("%.2f",$a) ; 
       # $dt = $a;
      # (24*60)  ;
     $site_code=substr($Fld2,0,7);
    #print "$Fld1|$Fld2|$Fld3|$Fld4|$dt\n" ;
     #print "substr($Fld2,1,7)~$dd[0]/$dd[1]/$dd[2]|$dt\n" ;
     if($dt<1000){
     	
     #	if( $Fld3 =~ m/00\:00\:00/ ){ print A "$Fld1|$Fld2|$Fld3|$Fld4|$Fld5|$dt\n" ; }
     #	if( $Fld4 =~ m/23\:59\:59/ ){ print  B "$Fld1|$Fld2|$Fld3|$Fld4|$Fld5|$dt\n" ; }
     #print "$site_code~$dd[0]/$dd[1]/$dd[2]|$dt\n" ;
    # if( ($Fld4 !~ m/23\:59\:59/) && ($Fld3 !~ m/00\:00\:00/) ) {print "$Fld1|$Fld2|$Fld3|$Fld4|$Fld5\n" } ;
      print "$Fld1|$Fld2|$Fld3|$Fld4|$Fld5\n"
    }
 
   my @results1 =`cat tmpf |  nawk 'FS="|" , OFS="|" { print $2 } ' | sort -u`;
    my @results2 =`cat tmpv |  nawk 'FS="|" , OFS="|" { print $2 } ' | sort -u`;
    
#    my($linef);
#my($linev);

   foreach $linef(@results1) # loop thru list
{
chomp;
 ($aa,$bb,$cc,$dd,$ee,$ff,$gg)=split(/[|\n]/,$linef,9999);
  #  print "$bb|$cc|$dd\n" ;
}
}

close(A,B)



