#USER_Module Name---------------------------------------------------
set modname "Up_Dn_Counter"

#USER_Inputs---------------------------------------------------
set in_ports [list IN Load Up Down CLK];
set in_ports_width [list 4 1 1 1 1];

#USER_Outputs---------------------------------------------------
set out_ports [list High Counter Low];
set out_ports_width [list 1 4 1];






















#CODE---------------------------------------------------
set i 0;
set j 0;
set last [llength $out_ports];

set fh [open module_dec.txt w+];


puts $fh "module $modname (";

foreach x $in_ports {

if {[lindex $in_ports_width $i]==1} {
	puts $fh "	input		 $x,";

} else {
	set a [expr [lindex $in_ports_width $i] - 1];
	puts $fh "	input	\[$a:0\]	 $x, "
}

incr i;
}

foreach y $out_ports {
if {$j != [expr $last -1]} {

	if {[lindex $out_ports_width $j]==1} {
		puts $fh "	output		 $y,";

	} else {
		set b [expr [lindex $out_ports_width $j] - 1];
		puts $fh "	output	\[$b:0\]	 $y, "
	}

} else {
	if {[lindex $out_ports_width $j]==1} {
		puts $fh "	output		 $y \n);\n\nendmodule";

	} else {
		set b [expr [lindex $out_ports_width $j] - 1];
		puts $fh "	output	\[$b:0\]	 $y \n); \n\nendmodule "
	}
}

incr j;
}
close $fh;