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

$host=new Net::Telnet (Timeout => 150,Prompt => '/mml>/');

$host -> open($hostname); $host -> login($username,$passwd);



$, = ' ';		# set output field separator
$\ = "\n";		# set output record separator

$FS = '|';
#   OFS="|"



        

chomp;


@cmd1=$host->cmd("LST ALMAF: ; " )   ;
print @cmd1;



