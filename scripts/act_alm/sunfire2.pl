#!/usr/perl5/5.6.1/bin/perl
my ($hostname,$username,$passwd);
$hostname="10.231.10.65";
$username="NOCCORDT";
$passwd="noccord1";

 print $hostname;


## Connect & Login
use lib '/home/NCOR6649/logs/core/net';
use Net::Telnet();

$host=new Net::Telnet (Timeout => 2500,Prompt => '/>/');

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



@cmd1=$host->cmd("cd /home/NOCCORDT/act ; sh AL ;" )   ;
print @cmd1;


