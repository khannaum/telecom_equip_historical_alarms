#!/usr/bin/perl -w

use Getopt::Std;

#Default parameter values
$opt_v = 0;
$opt_h = 0;
$opt_b = 0;
$opt_i = 0;
$opt_I = 0;
$opt_l = 0;

#Command line paramteters parsing
if (@ARGV == 1 && $ARGV[0] eq "--help") {
    printHelp();
    exit(0);
}elsif (!getopts("hvbiIl")) {
    printUsage();
    exit(1);
}elsif ($opt_h) {
    printHelp();
    exit(0);
}

if (($opt_l && @ARGV < 1) || (!$opt_l && @ARGV < 2)) {
    printUsage();
    exit(1);
}

if ($opt_l) {
    $bufferSeparatorPattern = '^$';
}
else {
    $bufferSeparatorPattern = shift(@ARGV);
}

$pattern = shift(@ARGV);
$inverse = $opt_v;
$separatorAtBeginning = $opt_b;
$ignoreCasePattern = $opt_i;
$ignoreCaseSeparator = $opt_I;

#-------------------------------------------------#

#Main loop
while (<>) {

    if ($ignoreCaseSeparator) { $separatorMatches = /$bufferSeparatorPattern/i }
                        else  { $separatorMatches = /$bufferSeparatorPattern/  }

    unless ($separatorMatches) {
	# if not separator - just append line to buffer.
	$buffer .= $_;
    }
    else {
	if ($separatorAtBeginning) {
	    #The buffer may be empty at the beginning
	    matchBuffer() if ($buffer);
	    $buffer = $_;
	}
	else {
	    $buffer .= $_;
	    matchBuffer();
	    $buffer = "";
	}
    }
}

#If something left in the buffer, check it also
if ($buffer) {
    matchBuffer();
}

#Successful exit
exit 0;

#-------------------------------------------------#

#Test if buffer matches pattern
sub matchBuffer {
    my($matches);

    if ($ignoreCasePattern) { $matches = $buffer =~ /$pattern/mi }
    else                    { $matches = $buffer =~ /$pattern/m  }

    $matches = !$matches if ($inverse);
    print $buffer if ($matches);
}

#-------------------------------------------------#

#Prints usage
sub printUsage {
    print "Usage: buffgrep [-h / --help] [-b] [-v] [-i] [-I] <[separator pattern]/[-l]> <pattern> [file1 file2 ...]\n";
}

#-------------------------------------------------#

#Prints help
sub printHelp {
    my($help);

$help =
    q{

       Buffgrep is a grep-like utility that operates on text blocks,
       rather than on single lines as in the regular grep case.

       Buffgrep reads lines from the specified files, or from standart
       input if no files were given and splits input into blocks (buffers)
       using separator pattern. Then, each buffer is tested vs given
       pattern and copied into the standard output if one or more of its
       lines matches the pattern.

Parameters:
       <separator pattern> - regular expression which identifies a line
       as a buffer separator. The line that matches this pattern is
       appended to the end of the buffer, unless -b option is used.

       <pattern> - pattern to test. Special symbols like ^/$ reffers to
       the beginning and end of each of the buffer's lines, not the entire
       buffer. The pattern uses Perl regular expressions syntax.

       -b - appends a line that matches the separator pattern to the
       beginning of the buffer rather than to it's end.

       -v - prints only the buffers that DO NOT match the pattern.

       -h - prints this help

       -i - ignores "pattern" case

       -I - ignores "separator pattern" case

       -l - uses empty line as a pattern sepatator. Therefore:
           buffgrep -l pattern
       is exactly the same as:
           buffgrep '^$' pattern

Examples:
       Lets suppose that hypotetical utility 'netdump' dumps net packets
       in textual formats (separated by an empty line) into standart
       output. So filtering packets by origin ("From" field in this example)
       may be done in this way:
           netdump | buffgrep -l 'From: Sun12'

       To find blocks of settings in windows-like ".ini" file which contain
       "window" attribute(s), the following form could be used:
           buffgrep -bi '^\[.*\]' "window" my_app.ini
       -b option is used here because the setting group header was used as
       a separator pattern and it should start the resulting block rather
       than end it.
       Beacause the -i option  was used, not only "window" and "window_id"
       will match the pattern, but also "mainWindow" and "WINDOW_ID".

Credits:
       Author: Zigmar

       This program is a free implementation of the original tool created
       by "MaK Technologies".
};

    printUsage();
    print $help;
}