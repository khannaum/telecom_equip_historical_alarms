#!/usr/bin/perl
use strict;
use warnings;
use Time::Local;

my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) =
                                                localtime(time);

printf("Today's date is: %02d.%02d.%02d\n", 
                       $mon+1, $mday, $year % 100);

my $date = "07.30.12";
my ($m,$d,$y) = split /\./, $date;

my $xmas_time = timelocal(0,0,0,$d,$m-1,$y);
my $today = time;
my $days_diff = int( ($today - $xmas_time) / (24*60*60) )-1 ;

print "Difference is $days_diff days\n";

