#!/usr/bin/perl
use strict;

print "Info: ARGV is: @ARGV\n";

while (<STDIN>) {
        chomp;
        next if /^\s*$/; # skip empty lines
        if (-e $_) { # a regular file (might be suited to your needs)
          # do something with $_ as if it were shifted from @ARGV
           print "handling file: $_\n";
        } else {
           warn "no such file: $_ \n";
        }
}
__END__
