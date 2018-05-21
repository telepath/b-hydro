outer_diameter = 70;
wall_thickness = 1.5;
width = 15;
height = 20;
thin = 0.01;
angle = 25;

/* d = height / tan(angle);
p = (outer_diameter - d)/2; */
p=outer_diameter * 0.33;

rotate([-angle, 0, 0]) {
  assembly();
}

module mantle(){
  intersection(){
    translate([0,-outer_diameter/2,-height/2-thin])
      cylinder(d=outer_diameter-width, h=height*2);
    translate([0,-wall_thickness*2,-height/2])
      difference(){
        cylinder(d=outer_diameter,h=height*1.5);
        translate([0,0,-thin])
          cylinder(d=outer_diameter-wall_thickness*2,h=height*2);
      }
  }
}

module assembly(){
  difference() {
    union() {
      ringcup();
      outlet();
      mantle();
    }
    outlet_inner();
    cutoff();
  }

}

module outlet_inner(){
  translate([0,-p,0])
    rotate([90+angle,0,0])
      translate([0,height/2,0])
        translate([0,0,-thin])
          cylinder(d=height-wall_thickness*2,h=height*2+thin*2);
}

module outlet(){
  difference(){
    translate([0,-p,0])
      rotate([90+angle,0,0])
        translate([0,height/2,0])
          cylinder(d=height,h=height*2);
    outer();
  }
}

module cutoff(){
  rotate([angle, 0, 0])
  translate([-outer_diameter, -outer_diameter, -height]) {
    cube(size=[outer_diameter*2, outer_diameter*2, height*1.5]);
  }
}

module ringcup(){
  difference(){
    outer();
    translate([0, 0, wall_thickness]) {
      inner();
    }
  }
}

module outer(){
    difference(){
      cylinder(d=outer_diameter,h=height);
      translate([0,0,-thin])
        cylinder(d=outer_diameter-width*2,h=height+2*thin);
    }
}

module inner(){
    difference(){
      cylinder(d=outer_diameter-2*wall_thickness,h=height);
      translate([0,0,-thin])
        cylinder(d=outer_diameter-width*2+wall_thickness*2,h=height+2*thin);
        cutoff();
    }
}
