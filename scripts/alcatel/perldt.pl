#!/usr/bin/perl
use warnings;
use strict;
my @output = `cd /home/noccord/scripts/; ./sitestatus`;
print @output,"\n";

