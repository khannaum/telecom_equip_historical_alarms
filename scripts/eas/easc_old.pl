#!/usr/perl5/5.6.1/bin/perl
 
 my $sumt;
# print "hello";
open(A, "<key_file");
open(B, "<eas_main_f");
my(@linea) = <A>; # read file into list
my(@lineb) = <B>; # read file into list
my($lineav);
my($linebv);


foreach $lineav (@linea) # loop thru list
{
chomp;
#print "NEW";
#print $lineav;
($a,$b,$c,$d,$e,$f,$g)=split(' ',$lineav);
 #print $a;
 foreach $linebv (@lineb) # loop thru list
{
chomp;
 ($aa,$bb,$cc,$dd,$ee,$ff,$gg)=split(/[|\n]/,$linebv,9999);
  #print "$aa|$bb\n";
   if($a eq $aa){$sumt=$sumt+$bb }
   
}

if($sumt>1440){$sumt=1440; }
print "$a|$sumt\n";
  $sumt=0;
}  
close A,B ;

