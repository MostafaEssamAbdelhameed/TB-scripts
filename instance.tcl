




#USER_Module Name---------------------------------------------------
set modname "TOP_rx"

#USER_Inputs---------------------------------------------------
set in_ports [list RX_IN prescale PAR_EN PAR_TYP clk rst ];

#USER_Outputs---------------------------------------------------
set out_ports [list P_DATA data_valid];




















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