include <lib/siphon2.scad>
include <lib/s-hydro/lib/hydroponics.scad>

w=1.5;

di=18;
fdo=di*1.5;
dii=10;
cdo=fdo+(di-dii)+w*2;

/* cut_view(y=1){ */
  /* screw_siphon(di=di,do=di+w*2,fdo=fdo,h=wb,w=w);
  cover_snorkel_holow(); */
/* } */

module cut_view(x=1000,y=1000,z=1000) {
  intersection(){
    translate([0, y/2, 0]) {
      cube(size=[x, y, z], center=true);
    }
    children();
  }
}

module cover_snorkel_holow() {
  cdi=cdo-w*2;
  h0=LidHeight+cdi-fdo;

  //inner pipe
  simple_pipe(do=dii+w*2,di=dii,h=wb);

  d1=(cdo-dii)/2;

  translate([0, 0, h0]) {
    difference() {
      union() {
        //top
        translate([0, 0, wb-h0]) {
          donut_top_holder(di=dii,do=cdo);
        }
        //outer pipe
        simple_pipe(do=cdo,di=cdo-w*2,h=wb-h0);
        //snorkel
        snorkel_outer(x=cdi/2+w,di=dii/2,w=w,h=wb-h0+d1*0.45-(dii/2+w*2)/2);
      }
      snorkel_inner(x=cdi/2+w,di=dii/2,w=w,h=wb-h0+d1*0.45-(dii/2+w*2)/2);
    }
  }

}

module donut_top_holder(di=dii,do=cdo,w=w,fdo=fdo) {
  d2=di+(do-di)/2;
  donut_top(di=dii,do=cdo,w=w);

  dh=(fdo-dii)/2-w;

  //holder
  for (i=[0:3]) {
    rotate(45+90*i) {
      translate([0, (di+dh)/2+w/2, dh/3.5]) {
        rotate([0, 90, 0]) {
          cylinder(d=dh, h=w, center=true,$fn=16);
        }
      }
    }
  }
}

module donut_top(di=dii,do=cdo,w=w) {
  d1=(do-di)/2;
  difference() {
    intersection() {
      cylinder(d=do+w*2, h=d1*0.45);
      torus_abs(di=di,do=do);
    }
    intersection() {
      cylinder(d=do+w*2, h=d1*0.45-w);
      torus_abs(di=di+w*2,do=do-w*2);
    }
  }
}
