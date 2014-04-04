//
//	Oregon Tech Print3D Rapid Prototyping Lab
//	
//	Author: Dustin Kerns
//	Project: Wintermute Delta Printer
//	Purpose: To redefine base HIMAWARI travel bracket to suit the needs of the Wintermute fork
//

// 
//	Generate model
//
TravelBracket();

//--------------------------------------------------------------------------------------------------------------------------------------

//
//	Module: NutSocket
//	Purpose: Defines the shape of a M3 Nut for screw mounts
//
module NutSocket(width,depth,height)
{
	side_length=sqrt(pow(width,2)/2);
	translate([0,0,height/2])cube([width,depth,height],center=true);
	rotate([0,45,0])cube([side_length,depth,side_length],center=true);
}


//
//	Module: Travel Bracket
//	Purpose: Revised Travel Bracket for Wintermute Delta Printer
//
module TravelBracket()
{

	standoff_height=1; // In mm

	difference()
	{
		// Fill in un-used aspects of base model and add new structure to the Travel Bracket
		union()
		{
			// Import base HIMAWIRI STL
			import("TRV_BRKT_V1_0.stl");
		
			// Fill in unneeded holes
			// These aspects of the original HIMAWRI base printer are not used on
			// the Wintermute fork
			translate([16,17,3])rotate([90,0,0])cylinder(h=10,r=1.8,$fn=40);
			translate([16,17,11])rotate([90,0,0])cylinder(h=10,r=1.8,$fn=40);
			translate([22,9,0])cube([6,8,14]);
			translate([-22,9,0])mirror([1,0,0])cube([6,8,14]);
			translate([22,-9,0])mirror([0,1,0])cube([6,6,14]);
			translate([-22,-9,0])mirror([1,1,0])cube([6,6,14]);
			translate([13,11,0])cube([6,3,14]);

			// Smooth out holes for linear bearings and generate standoff
			difference()
			{

				// Cylinder defining the outer shell
				union()
				{
					translate([25,0,0])cylinder(h=14+standoff_height,r=10,$fn=40);
					translate([-25,0,0])cylinder(h=14+standoff_height,r=10,$fn=40);
				}

				// Cylider defining the inner section to be removed
				// (Where the linear bearings will fit)
				union()
				{
					translate([25,0,-1])cylinder(h=18,r=8,$fn=40);
					translate([-25,0,-1])cylinder(h=18,r=8,$fn=40);
				}
			}				
		}
		
		// Holes for set screws to add further support for linear bearings
		translate([-25,0,7])rotate([90,0,0])cylinder(h=40,r=1.8,$fn=40,center=true);
		translate([25,0,7])rotate([90,0,0])cylinder(h=40,r=1.8,$fn=40,center=true);

		// Nut sockets for M3 set screws
		translate([-25,12.5,5.5])NutSocket(6,3,14);
		translate([25,12.5,5.5])NutSocket(6,3,14);
		mirror([0,1,0])translate([-25,11,5.5])NutSocket(6,3,14);
		mirror([0,1,0])translate([25,11,5.5])NutSocket(6,3,14);
	}
}