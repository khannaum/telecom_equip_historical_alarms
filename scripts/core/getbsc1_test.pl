#!/usr/perl5/5.6.1/bin/perl
my ($hostname,$username,$passwd);

#$hostname="10.31.24.25";
$username="noc_core";
$passwd="Mobilink123";

$hostname="$ARGV[0]";
# print $hostname;
## Connect & Login
use lib '/home/oann/logs/core/net';
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

open(A, "<gath");
my(@lines) = <A>; # read file into list
my($line);
foreach $line (@lines) # loop thru list
{
chomp;

($a,$b,$c,$d,$e,$f,$g)=split(/[|\n]/,$line,9999);

print "line:",$line;

@cmd1=$host->cmd("LST TDMTID: TIDFVDEC=$g ;" )   ;
print @cmd1;

}

