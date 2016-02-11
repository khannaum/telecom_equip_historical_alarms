#!/usr/bin/perl
use strict;
use warnings;
use POSIX qw/ strftime /;

# Script to get prior Monday (if today is Mon, then Mon a week ago).

print scalar localtime, "\n", last_monday(localtime);

sub last_monday {
    my ($wday, @dmy) = @_[6, 3..5];
    
    # (will work across month, year boundries)
    # $dmy[0] -= ($wday+6) % 7 || 7; # $dmy[0] == mday

   $dmy[0] -= ($wday+6) % 7 || 7; # $dmy[0] == mday

    return strftime "%Y%m%d000000", 0,0,0,@dmy;
}

