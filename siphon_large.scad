include <lib/v-hydro/hydroponics.scad>
include <lib/v-hydro/lib/nozzle.scad>
include <conf/large_config.scad>

// outer diameter of funnel
do=d;
hf=tl;
w=1.5;

/* rotate([180,0,0]) */
  siphon();
  /* siphon2(); */
  /* cover(); */

module cover() {
  translate([0, 0, wb-hf*2]) {
    cover_inlet();
    translate([0, 0, ts*2]) {
      funnel();
    }
  }
}

module cover_inlet() {
  male();
  translate([0, 0, ts]) {
    difference() {
      cylinder(d=bd+w*2, h=ts);
      translate([0, 0, -f]) {
        cylinder(d=bd, h=ts+f*2);
      }
    }
  }
}

module siphon2(){
  pipe(wb-hf*2);
  translate([0, 0, wb-hf*2]) {
    funnel();
  }
}

module funnel() {
  difference() {
    translate([0, 0, -w]) {
      cylinder(d1=bd+w*2, d2=bd*2+w*2, h=hf+w);
    }
    translate([0, 0, -f]) {
      cylinder(d1=t+tt*2, d2=bd*2, h=hf+f*2);
    }
    translate([0, 0, -w-f]) {
      cylinder(d=t+tt*2, h=hf*2);
    }
  }
}

module siphon(){
  do=bd+w*2;
  di=bd;
  h0=tl;
  dhl=di/2; //lower hole diameter
  duh=di/3; //upper hole diameter
  nz=5; //nozzle size (inner)
  nl=tl; //nozzle lenght

  // nozzle
  union(){
    translate([0, 0, h0/2]) {
      difference() {
        union() {
          cylinder(d1=nz+w*2.5, d2=ti, h=h0/2-w);
          translate([0, 0, h0/2-w]) {
            cylinder(d=ti, h=w);
          }
        }
      translate([0, 0, w]) {
        cylinder(d1=nz, d2=ti, h=h0/2-w+f);
      }
      translate([0, 0, -f]) {
        cylinder(d=nz, h=h0+w*2);
      }
    }
  }
  translate([0, 0, h0/2-nl]) {
    nozzle(l=nl,do=nz+w,di=nz,mw=w/2,n1=w*0.25,n2=-w*0.75);
  }
}

  // 1: thread
  h1=h0+ts;
  difference() {
    translate([0,0,h0])
      male();
    translate([0,0,h1])
      holes_lower(d=dhl,do=do);
  }
  // bottom
  translate([0,0,h0]){
    difference(){
      cylinder(d=do,h=w);
      translate([0,0,-f])
        cube([t,t,w+f*2]);
      translate([-t,-t,-f])
        cube([t,t,w+f*2]);
    }
  }

  // 1-1: subdevisions
  difference() {
    union() {
      translate([-di/2,-w/2,h0])
        cube([di,w,wb+ts-h0]);
      translate([-w/2,-di/2,h0])
        cube([w,di,wb+ts-h0]);
    }
  // 1-2: holes
    translate([0, 0, wb]) {
      hole_upper(d=duh,di=di);
      rotate(-90)
        hole_upper(d=duh,di=di);
    }
  }

  // 2: hull
  h2=wb+ts-h1;
  translate([0,0,h1])
    difference(){
      cylinder(d=do,h=h2);
      translate([0,0,-f])
        cylinder(d=di,h=h2+f*2);
  // 2-2: holes
      holes_lower(d=dhl,do=do);
    }

  // 3: lid
  h3=wb+ts;
  translate([0,0,wb+ts-w]){
    difference(){
      cylinder(d=do,h=w);
      translate([0,0,-f])
        cube([t,t,w+f*2]);
    }
  }

  // 4: upper thread (optional)
  /* h4=h3+tl;
  translate([0,0,h3]) {
    female();
  }
  translate([-di/2+w*2.5,-w/2,h3])
    cube([di-w*5,w,tl+w]);
  translate([-w/2,-di/2+w*2.5,h3])
    cube([w,di-w*5,tl+w]); */
}

module holes_lower(d,do,w=w) {
  for (i=[0:1]) {
    rotate(180*i-45) {
      translate([do/2-w*2, 0, w]) {
        hole(d);
      }
    }
  }
}

module hole_upper(d,di,w=w) {
  translate([0, -di/4, 0]) {
    hole(d);
  }
}

module hole(d,w=w) {
  cube([w*4,d,w*6],center=true);
}
