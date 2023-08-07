#USER_Module Name---------------------------------------------------
set modname "Up_Dn_Counter"

#USER_Inputs---------------------------------------------------
set in_ports [list IN Load Up Down CLK rst];

#USER_Outputs---------------------------------------------------
set out_ports [list High Counter Low];




















#CODE---------------------------------------------------
set i 0;
set j 0;
set last [llength $out_ports];

set fh [open instance.txt w+];

puts $fh " $modname DUT (";

foreach x $in_ports {

	puts $fh "		.$x\($x\_tb),";

incr i;
}

foreach y $out_ports {
	if {$j != [expr $last -1]} {

			puts $fh "		.$y\($y\_tb),";
			
		} else {
		
			puts $fh "		.$y\($y\_tb)";
			puts $fh "		);";
			
		}

incr j;
}
close $fh