include <configuration.scad>;

separation = 44;  // Distance between ball joint mounting faces.
offset = 22;  // Same as DELTA_EFFECTOR_OFFSET in Marlin.
mount_radius = 18.5;  // Hotend mounting screws, standard would be 25mm.
jhead_od_radius = 8;  // Hole for the hotend (J-Head diameter is 16mm).
jhead_id_radius = 6;
height = 7;
jhead_height=5;
mount_height=31;


module mount() {
  difference() {
    union() {
		cylinder(r=offset-5, h=height, center=true, $fn=36);
		
		for (a = [0:120:359]) rotate([0, 0, a]) {
      	translate([0, mount_radius, 0])	cylinder(r1=8.5,r2=7.5, h=height, center=true, $fn=36);
    		}
		   
    }

	 for (a = [0:120:359]) rotate([0, 0, a]) {
      translate([0, mount_radius, 0])
			cylinder(r=m3_wide_radius, h=2*mount_height+height, center=true, $fn=12);
    }

    translate([0, 0, -height/2])cylinder(r=jhead_id_radius, h=height, $fn=36); 
    translate([0, 0, 1.5])cylinder(r=jhead_od_radius, h=2, $fn=36);

	 rotate([0, 0, 60])translate([0,offset/2,-1])
			cube([jhead_id_radius*2,offset,jhead_height],center=true);
	 rotate([0, 0, 60])translate([0,offset/2,2.5])
			cube ([jhead_od_radius*2,offset,2],center=true);


    for (a = [60:120:359]) rotate([0, 0, a]) {
      translate([0, offset, height/2])	cylinder(r1=12,r2=14, h=2*height, center=true, $fn=36);
    }

  }
}

translate([0, 0, height/2]) mount();