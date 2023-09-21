





#USER_Module Name---------------------------------------------------
set modname "System_Top"

#USER_Inputs---------------------------------------------------
set in_ports [list ref_clk uart_clk rst RX_IN];
set in_ports_width [list 1 1 1 1];

#USER_Outputs---------------------------------------------------
set out_ports [list TX_OUT stop_err par_err];
set out_ports_width [list 1 1 1];
















#CODE---------------------------------------------------
set i 0;
set j 0;
set last [llength $out_ports];

set fh [open tb.txt w+];

puts $fh "`timescale 1ns / 1ps\n";

puts $fh "module $modname\_tb ();\n";
puts $fh "/////////////////////////////////////////////////////
//////////////////clk_generator//////////////////////
/////////////////////////////////////////////////////\n";
puts $fh "parameter clk_period= 20; \nreg clk_tb=0; \nalways #(clk_period/2) clk_tb = ~clk_tb;";
puts $fh "\n/////////////////////////////////////////////////////
///////////////Decleration & Instances///////////////
/////////////////////////////////////////////////////\n";
foreach x $in_ports {

if {[lindex $in_ports_width $i]==1} {
	puts $fh "reg		$x\_tb;";

} else {
	set a [expr [lindex $in_ports_width $i] - 1];
	puts $fh "reg \[$a:0\]	$x\_tb; "
}

incr i;
}

foreach y $out_ports {
if {$j != [expr $last -1]} {

	if {[lindex $out_ports_width $j]==1} {
		puts $fh "wire			$y\_tb;";
	
	} else {
		set b [expr [lindex $out_ports_width $j] - 1];
		puts $fh "wire	\[$b:0\]	$y\_tb; "
	}

} else {
	if {[lindex $out_ports_width $j]==1} {
		puts $fh "wire			$y\_tb;";

	} else {
		set b [expr [lindex $out_ports_width $j] - 1];
		puts $fh "wire	\[$b:0\]	$y\_tb;"
	}
}

incr j;
}

set fh2 [open instance.txt r+];
set instance [read $fh2];
puts $fh "\n$instance";
puts $fh "\n/////////////////////////////////////////////////////
///////////////////Initial Block/////////////////////
/////////////////////////////////////////////////////\n";
puts $fh "initial begin \n	\$dumpfile(\"$modname\.vcd\"); \n	\$dumpvars; \nend ";

puts $fh "\n/////////////////////////////////////////////////////
//////////////////////Tasks//////////////////////////
/////////////////////////////////////////////////////\n";

puts $fh "task reset;
 begin
 rst_tb=1;
 #(clk_period)
 rst_tb=0;
 #(clk_period)
 rst_tb=1;
 end
endtask";

puts $fh "endmodule"
close $fh;
close $fh2;