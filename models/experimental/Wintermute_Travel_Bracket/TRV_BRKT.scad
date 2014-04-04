// Module containing code for revised Travel Bracket for Wintermute Delta Printer
module TravelBracket()
{
	difference()
	{
		union()
		{
			// Import base HIMAWIRI STL from approved directory
			import("..//..//approved//TRV_BRKT.stl");
		
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

			// Linear bearing holes
			difference()
			{
				// Cylinder defining the outer shell
				union()
				{
					translate([25,0,0])cylinder(h=16,r=10,$fn=40);	// Left
					translate([-25,0,0])cylinder(h=16,r=10,$fn=40);	// Right
				}

				// Cylider defining the inner section to be removed
				// (Where the linear bearings will fit)
				union()
				{
					translate([25,0,-1])cylinder(h=18,r=8,$fn=40);	// Left
					translate([-25,0,-1])cylinder(h=18,r=8,$fn=40);	// Right
				}
			}				
		}		
		// Holes for set screws to add further support for linear bearings
		translate([-25,0,7])rotate([90,0,0])cylinder(h=40,r=1.8,$fn=40,center=true);
		translate([25,0,7])rotate([90,0,0])cylinder(h=40,r=1.8,$fn=40,center=true);		
	}
}

// Module defining the shape of a M3 Nut for screw mounts
module NutSocket(width,depth,height)
{
	side_length=sqrt(pow(width,2)/2);
	translate([0,0,height/2])cube([width,depth,height],center=true);
	rotate([0,45,0])cube([side_length,depth,side_length],center=true);
}

difference()
{
	TravelBracket();

	union()
{
		translate([-25,12.5,5.5])NutSocket(6,3,14);
		translate([25,12.5,5.5])NutSocket(6,3,14);
		mirror([0,1,0])translate([-25,11,5.5])NutSocket(6,3,14);
		mirror([0,1,0])translate([25,11,5.5])NutSocket(6,3,14);
	}
}