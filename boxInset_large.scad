include <s-hydro/hydroponics.scad>
include <large_config.scad>

rotate(90){
  finish_inset3();
}

rotate(45)
    divider_cut(x=x,z=z-w*5,d=5,w=w);
/* divider_finish(x=x/2,z=z-w*5,d=5,w=w); */


module divider_finish(x,z,d,w) {
  minkowski() {
    sphere(d=w);
    divider(x=x,z=z,d=d,w=w);
  }
}

module divider_cut(x=x,z=z-w*5,b=b,w=w) {
  intersection() {
    block(x=x,y=x,z=z,b=b,rn=1,sq=0);
    translate([x/3, 0, 0]) {
      divider(x=x/2,z=z,d=5,w=w);
    }
  }
}

module divider(x=x,z=z,d,w=w) {
  C=3.14*x;
  nh=C/(d*1.75);
  nv=z/(d*1.75);
  translate([0, 0, 0]) {
    difference() {
      cylinder(d=x, h=z);
      cylinder(d=x-w*2, h=z+f);
      for (j=[1:nv-3]) {
        rotate(360/nh*(j/2 - floor(j/2))-0.5) {
          translate([0, 0, d*2*j]) {
            for (i=[1:nh]) {
              rotate(360/nh*i) {
                rotate([90, 0, 0]) {
                  cylinder(d=d+w, h=x);
                  /* hole(x=x/2-w,d=d,w=w); */
                }
              }
            }
          }
        }
      }
    }
  }
}

module hole(x,d,w) {
  difference() {
    translate([x, 0, 0]) {
      rotate([0, 90, 0]) {
        cylinder(d=d+w, h=w*2, center=true);
      }
    }
    hole_border(x=x,d=d,w=w);
  }
}
/* #hole_border(x=x/4,d=5,w=w); */
module hole_border(x,d,w) {
  translate([x, 0, 0]) {
    rotate([0,90,0]) {
      torus(d1=w,d2=d+w);
    }
  }
}

module torus(d1,d2){
  rotate_extrude(convexity=10) {
    translate([d2/2, 0, 0]) {
      circle(d=d1);
    }
  }
}
