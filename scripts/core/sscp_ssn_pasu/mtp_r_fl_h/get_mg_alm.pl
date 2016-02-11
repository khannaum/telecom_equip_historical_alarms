#!/usr/perl5/5.6.1/bin/perl
my ($hostname,$username,$passwd);

#$hostname="10.31.24.25";
#$username="nocfm";
#$passwd="Mobilink123";

$hostname="$ARGV[0]";

$hostname="$ARGV[0]";
$username="$ARGV[1]";
$passwd="$ARGV[2]";
$sdv="$ARGV[4]";

##sd=2011&09&29



 print $hostname,$username,$passwd,$sdv;
## Connect & Login
use lib '/home/oann/logs/core/net';
use Net::Telnet();

$host=new Net::Telnet (Timeout => 100,Prompt => '/mml>/');

$host -> open($hostname); $host -> login($username,$passwd);



$, = ' ';		# set output field separator
$\ = "\n";		# set output record separator

$FS = '|';
#   OFS="|"



        

chomp;


@cmd1=$host->cmd("LST ALMLOG:  CLRFLG=CLEARED-1&UNCLEARED-1, STARTAID=1705, ASS=POWER-1&ENV-1&SIG-1&TRUNK-1&HARDWARE-1&SOFTWARE-1&RUN-1&COMM-1&SERVICE-1&HANDLE-1, SD=$sdv; " )   ;
print @cmd1;



