#!/usr/perl5/5.6.1/bin/perl
 
 my $sumt=0;
# print "hello";
open(A, "<key_file");
open(B, "<eas_main_f");
open(C, "<keyf");
my(@linea) = <A>; # read file into list
my(@lineb) = <B>; # read file into list
my(@linec) = <C>; # read file into list
my($lineav);
my($linebv);
my($result);
my($linecv);
my($linedv);
foreach $linecv (@linec) # loop thru list
{
chomp;
#print "NEW";
#print $lineav;
($a,$b,$c,$d,$e,$f,$g)=split(' ',$linecv);
 # print "$a\n";
# @results = grep /$a/, @linea;
  my @results =`grep -s "$a" key_file`;
  my @results1 =`grep -s "$a"  eas_main_f`;
  my $code= substr($a,0,7) ;
  #print "$code\n";
  my $results5 =`grep  -i "$code"  /home/NCOR6649/scripts/RSL/cell`; 
   ($site,$ncell,$vendd)=split(/[|\n]/,$results5);
  # print "$site\n";
 #my @results1 = grep /$a/, @lineb;
 
 #print "@results\n";
 
 
 #
 foreach $lineav (@results) # loop thru list
{
chomp;
 ($aa,$bb,$cc,$dd,$ee,$ff,$gg)=split(/[|\n]/,$lineav,9999);
     #print "$aa|$bb\n";
   
     my @results3 = grep $aa, @results1;
     
    foreach $linedv (@results3) # loop thru list
    {
      ($aaa,$bbb,$ccc,$ddd,$eee,$fff,$ggg)=split(/[|\n]/,$linedv,9999);
       # print "$aa|$aaa|$bbb|\n" ;
        if($aa eq $aaa){$sumt=$sumt+$bbb }
   
     }

     if($sumt>1440){$sumt=1440; }
        #print "$aa|$sumt|$ncell\n";
      if($ncell==0){$ncell=1;}
       $sumt=(1-( int($sumt)/ (int($ncell)*1440) ))*100;
       if($vendd =~ /Motorola/){$sumt=1-(($sumt*$ncell)/1440) ; }
      #print "$aa|$sumt\n";
      my $avt = sprintf("%.2f%%",$sumt);
      print "$aa|$avt\n";
     $sumt=0;
}

} 
close A,B,C ;

