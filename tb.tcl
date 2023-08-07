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

set fh [open tb.txt w+];


puts $fh "module $modname\_tb ()\n";
puts $fh "/////////////////////////////////////////////////////
//////////////////clk_generator//////////////////////
/////////////////////////////////////////////////////\n";
puts $fh "parameter clk_period= 20; \nreg clk_tb=0; \nalways #(clk_period/2) clk_tb = ~clk_tb;";
puts $fh "\n/////////////////////////////////////////////////////
///////////////Decleration & Instances///////////////
/////////////////////////////////////////////////////\n";
foreach x $in_ports {

if {[lindex $in_ports_width $i]==1} {
	puts $fh "wire		$x\_tb;";

} else {
	set a [expr [lindex $in_ports_width $i] - 1];
	puts $fh "wire \[$a:0\]	$x\_tb; "
}

incr i;
}

foreach y $out_ports {
if {$j != [expr $last -1]} {

	if {[lindex $out_ports_width $j]==1} {
		puts $fh "reg			$y\_tb;";
	
	} else {
		set b [expr [lindex $out_ports_width $j] - 1];
		puts $fh "reg	\[$b:0\]	$y\_tb; "
	}

} else {
	if {[lindex $out_ports_width $j]==1} {
		puts $fh "reg			$y\_tb;";

	} else {
		set b [expr [lindex $out_ports_width $j] - 1];
		puts $fh "reg	\[$b:0\]	$y\_tb;"
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

close $fh;
close $fh2;