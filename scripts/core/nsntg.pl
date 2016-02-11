#!/usr/perl5/5.6.1/bin/perl

my ($hostname,$username,$passwd);

#$hostname="10.31.24.25";
$username="NOCNUC";
$passwd="MOBILINK9";

#$hostname="$ARGV[0]";

$hostname="$ARGV[0]";
#$username="$ARGV[1]";
#$passwd="$ARGV[2]";

#print $ARGV[0],$ARGV[1];


# print $hostname,$username,$passwd;


## Connect & Login
use lib '/home/oann/logs/core/net';
use Net::Telnet();

 $host=new Net::Telnet (Timeout => 400,Prompt => '/[<>]/');
$fh = $host->input_log("nsntg.txt");
#$fh1=$host->output_log("log.txt");
# $fh2=$host->dump_log("dlog.txt");

$host -> open($hostname); 
# $host -> login($username,$passwd);

@cmd1=$host->cmd("NOCNUC");
print @cmd1;

@cmd2=$host->cmd("MOBILINK9");
print @cmd2;

#chomp;
sleep(2);

@ok = $host->getline;
@ok1 = $host->getline;
# @ok2 = $host->getline;
# @ok3 = $host->getline;

# print @ok;

@cmd3=$host->cmd("ZRCI:SEA=1:TYPE=ECCS:PRINT=5:;");
print @cmd3;
$secs=20;
@cmd4=$host->getlines(Timeout=>$secs);
@cmd5=$host->break;

# print @cmd4;

