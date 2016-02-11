#!/usr/perl5/5.6.1/bin/perl

use lib '/home/oann/logs/core/net';
    
my ($hostname,$username,$passwd);

$hostname="10.231.10.40";
$username="oans";
$passwd="oans123";

## Connect & Login

use Net::Telnet();

$host=new Net::Telnet (Timeout => 100,Prompt => '/[%#>] $/');

$host -> open($hostname); $host -> login($username,$passwd);

@lines = $host->cmd("who");
    print @lines;
