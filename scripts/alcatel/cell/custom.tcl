# simplegraph.tcl --
 #    Script to read and display timeseries
 #
 # Notes:
 #    This script defines a number of procs that can be overridden
 #    via a customised script file in the working directory:
 #    - openFile   - to open a file and prepare for reading
 #    - readNames  - to read the names of the series
 #    - readData   - to read the data for the series
 #    This is done specifically to make it possible to read (almost)
 #    any file without touching the script itself.
 #    The script file should be called "custom.tcl"
 #    The main script defines default procs that should be effective
 #    for simple cases.

 # openFile --
 #    Open the file and start looking for data
 #
 # Arguments:
 #    filename    Name of the file to read
 #
 # Result:
 #    infile      Handle to the opened file
 #
 # Side effects:
 #    A file in question is opened. Lines containing a * or # as
 #    the first non-blank character are considered comments. The
 #    first line without this is considered to be a line with the
 #    names of the columns.
 #
 proc openFile {filename} {
    set infile [open $filename "r"]
    return $infile
 }

 # readNames --
 #    Read the names of the columns
 #
 # Arguments:
 #    infile      Handle to the file
 #
 # Result:
 #    names       List of names, the number indicates the number of
 #                columns
 #
 proc readNames {infile} {
    #
    # Skip the header - if any
    #
    set pos    0
    while { [gets $infile line] >= 0 } {
       if { [regexp {[ \t]*[*#]} $line] } {
          incr pos
       } else {
          break
       }
    }
    seek $infile 0 start
    while { $pos > 0 } {
       gets $infile line
       incr pos -1
    }

    #
    # Read the line with the column names
    #
    gets $infile line

    # Force the line to be interpreted as a list
    set nocols [llength $line]

    return $line
 }

 # readData --
 #    Read the data per line
 #
 # Arguments:
 #    infile      Handle to the file
 #
 # Result:
 #    values      List of values, representing each column.
 #                A list of length zero indicates the end of file
 #
 proc readData {infile} {
    while { [gets $infile values] == 0 } { ;# Just go on - skip empty lines }

    set nocols [llength $values]

    return $values
 }

 # readFile --
 #    Read the file and store the data in a (global) array
 #
 # Arguments:
 #    filename    Name of the file
 #
 # Result:
 #    None
 #
 # Side effects:
 #    Filled array, ready for display
 #
 proc readFile {filename} {
    global data_array

    set infile [openFile $filename]

    set data_array(names) [readNames $infile]
    set i 0
    foreach name $data_array(names) {
       set data_array($i) {}
       incr i
    }

    while 1 {
       set values [readData $infile]
       if { [llength $values] > 0 } {
          set i 0
          foreach value $values {
             lappend data_array($i) $value
             incr i
          }
       } else {
          break
       }
    }
 }

 # makePlotData --
 #    Make a list useable by emu_graph
 #
 # Arguments:
 #    xindex     Index of x data
 #    yindex     Index of y data
 #
 # Result:
 #    None
 #
 # Side effects:
 #    A dataset for emu_graph
 #
 proc makePlotData {xindex yindex} {
    global data_array

    set xydata {}
    foreach x $data_array($xindex) y $data_array($yindex) {
       lappend xydata $x $y
    }

    plot data xydata -colour black -lines 1 -points 0 -coords $xydata
 }

 # updatePlot --
 #    Update the plot data
 #
 # Arguments:
 #    name       Name of the variable
 #    op         Operation (both ignored)
 #
 # Result:
 #    None
 #
 # Side effects:
 #    New plot data for the graph
 #
 proc updatePlot {name op} {
    global data_array

    set xindex [lsearch $data_array(names) $::xname]
    set yindex [lsearch $data_array(names) $::yname]
    makePlotData $xindex $yindex
 }

 # mainWindow --
 #    Create the main window
 #
 # Arguments:
 #    None
 #
 # Result:
 #    None
 #
 # Side effects:
 #    A toplevel window with a canvas and some buttons
 #
 proc mainWindow {} {
    global data_array

    frame  .frm
    eval tk_optionMenu .frm.x xname $data_array(names)
    eval tk_optionMenu .frm.y yname $data_array(names)
    set ::xname [lindex $data_array(names) 0]
    set ::yname [lindex $data_array(names) 1]

    .frm.x configure -width 10
    .frm.y configure -width 10

    trace variable ::xname w {after 200 updatePlot}
    trace variable ::yname w {after 200 updatePlot}

    pack .frm.x .frm.y -side top

    canvas .cnv -width 600 -height 400 -background lightgrey
    button .exit -text "Exit" -command "exit"
    pack .frm .cnv  -side left
    pack .exit -side top
    emu_graph plot -canvas .cnv -width 400 -height 300
 }

 # main --
 #    Main code, controlling the program
 #

 
 

  global data_array

#if { [file exists "custom.tcl"] } {
#  source "custom.tcl"
#}
 readFile [lindex $::argv 0]

 #
 # Get emu_graph
 #
# source "graph.tcl"

 mainWindow
 makePlotData 0 1
