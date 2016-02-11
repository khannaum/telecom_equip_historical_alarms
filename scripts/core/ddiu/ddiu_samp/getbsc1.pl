#!/usr/perl5/5.6.1/bin/perl
my ($hostname,$username,$passwd);

#$hostname="10.31.24.25";
#$username="nocfm";
#$passwd="Mobilink123";

$hostname="$ARGV[0]";

$hostname="$ARGV[0]";
$username="$ARGV[1]";
$passwd="$ARGV[2]";




 print $hostname,$username,$passwd;
## Connect & Login
use lib '/home/NCOR6649/logs/core/net';
use Net::Telnet();

$host=new Net::Telnet (Timeout => 100,Prompt => '/mml>/');

$host -> open($hostname); $host -> login($username,$passwd);



$, = ' ';		# set output field separator
$\ = "\n";		# set output record separator

$FS = '|';
#   OFS="|"



        
     # @cmd1=$host->cmd("LST TDMTID: TIDFVDEC=$Fld4 ;" )   ;

       # print $_;
       # print $ARGV[0],$ARGV[1]; 
       # print @cmd1 ;

#($a)=split(/[|\n]/, $ARGV[1],9999);
#print $a;
#@cmd1=$host->cmd("LST TDMTID: TIDFVDEC=$a ;" )   ;
#print @cmd1;

open(A, "<lk");
my(@lines) = <A>; # read file into list
my($line);
#foreach $line (@lines) # loop thru list

for (my $x= 0; $x<= $#lines; $x)
{
  my $line = $lines[$x];
  chomp;

($a,$b,$c,$d,$e,$f,$g,$h,$i)=split(/[|\n]/,$line,9999);

($ff,$gg)=split(/[-\n]/,$h,9999);


print "line:",$line;

@cmd1=$host->cmd("LST TDMTID: TIDFVDEC=$ff ;" )   ;
print @cmd1;

    my $lop=$h ;
   my $llop=$gg ;

   my $lop2=$lop ;
   my $llop2=$llop;
  # print " Start==========" ;

  while(( $lop2 eq $lop )   )
  {

    # $_ = &Getline0();

      $x++ ;

      ($a1,$b1,$c1,$d1,$e1,$f1,$g1,$h1,$i1)=split(/[|\n]/,$lines[$x],9999);


        #   $x++ ;

        $lop2=$h1 ;

        ($ff1,$gg)=split(/[-\n]/,$lop2,9999);

       if( ( $lop2 eq $lop )  && ( ($gg-$ff1) < 31 ) )
       {
       
             $ff=$ff+1 ;
        # $llop2=$ff ;

      print "line:",$lines[$x];

      @cmd2=$host->cmd("LST TDMTID: TIDFVDEC=$ff ;" )   ;
      print @cmd2;
      }

      # $x++ ;

      # $lop2=$h1 ;
      # $ff=$ff+1 ;  


   }

   # print " Stop ==============" ; 

}

