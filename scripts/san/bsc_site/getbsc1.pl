#!/usr/perl5/5.6.1/bin/perl




        

open(A, "<bsc_site_ct.csv");
open(B, "<today_st");

my(@lines) = <A>; # read file into list
my($line);

my(@llines) = <B>; # read file into list
my($lline);

#foreach $line (@lines) # loop thru list


for (my $x= 0; $x<= $#lines; $x=$x+1)
{
  my $line = $lines[$x];
 # chomp;

($a,$b,$c)=split(/[,\n]/,$line);

   $text_to_search=substr($a,0,7);

   $alr=0; 
 
    for (my $y= 0; $y<= $#llines; $y=$y+1)
    {
     my $lline = $llines[$y];
       #chomp;

     ($aa,$bb,$cc,$dd)=split(/[ \n]/,$lline);

      # print "$c,$aa\n" ;

       # $diff=$c-$aa ;
      #print $jj,"\n" ;
     
     $search_string=substr($bb,0,7);

     #print $search_string ;

      # $alr=0 ;

    if($text_to_search =~ m/\Q$search_string/ ){ $diff=int($c)-int($aa) ; print "$a|$b|$c|$aa|$diff \n"  ; $alr=1 ; }

     # $y=$y+1 ; 
     #print $alr;
    }

   if($alr==0){ print "$a|$b|$c|0|0\n"   } 

  # $x=$x+1 ;
}
