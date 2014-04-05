module TravelBracket(){
difference(){
    union(){
        import("C://Print3D//Printers//Wintermute//models//approved//TRV_BRKT.stl");
                
            // Fill in unneeded holes
            color([255,0,0])translate([16,17,3])rotate([90,0,0])cylinder(h=10,r=1.8,$fn=40);
            color([255,0,0])translate([16,17,11])rotate([90,0,0])cylinder(h=10,r=1.8,$fn=40);

            translate([22,9,0])cube([6,8,14]);
            translate([-22,9,0])mirror([1,0,0])cube([6,8,14]);
            translate([22,-9,0])mirror([0,1,0])cube([6,6,14]);
            translate([-22,-9,0])mirror([1,1,0])cube([6,6,14]);

            translate([13,11,0])cube([6,3,14]);

            // Linear bearing holes
            difference(){
                union(){
                translate([25,0,0])cylinder(h=14,r=10,$fn=40);
                translate([-25,0,0])cylinder(h=14,r=10,$fn=40);
                }

                union(){
                    translate([25,0,-1])cylinder(h=24,r=8,$fn=40);
                    translate([-25,0,-1])cylinder(h=18,r=8,$fn=40);
               }
           }                                
    }
                
          // Mount screw Linear bearing
          translate([-25,0,7])rotate([90,0,0])cylinder(h=40,r=1.8,$fn=40,center=true);
          translate([25,0,7])rotate([90,0,0])cylinder(h=40,r=1.8,$fn=40,center=true);             

}


}

module NutSocket(width,depth,height)
{
        side_length=sqrt(pow(width,2)/2);
        translate([0,0,height/2])cube([width,depth,height],center=true);
        rotate([0,45,0])cube([side_length,depth,side_length],center=true);
}

difference(){
        TravelBracket();

        union(){
                translate([-25,12.5,5.5])NutSocket(6,3,14);
                translate([25,12.5,5.5])NutSocket(6,3,14);
                mirror([0,1,0])translate([-25,11,5.5])NutSocket(6,3,14);
                mirror([0,1,0])translate([25,11,5.5])NutSocket(6,3,14);
        }
}
