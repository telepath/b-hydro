include <lib/s-hydro/lib/hydroponics.scad>
include <lib/v-hydro/lib/nozzle.scad>
include <conf/large_config.scad>

// outer diameter of funnel
do=d;
hf=tl;
fo=bd*1.5;

/* rotate([180,0,0]) */
  /* siphon(); */
  siphon2();
  cover_inlet2();
  /* %cover(); */

module cover() {
  /* translate([0, 0, wb-tl+hf]) {
    cylinder(d=bd*2, h=w);
  } */
  difference() {
    cylinder(d=bd*2+w*2, h=wb-tl+hf+w);
    cylinder(d=bd*2, h=(wb-tl+hf)*2,center=true);
  }
}

module cover_inlet2() {
  n=5;
  translate([0, 0, wb-hf*2]) {
    difference(){
      male(hf*2,4);
      for (i=[0:n-1]) {
        render()
        inlet(i*360/n,w*3);
      }
    }
    /* translate([0, 0, ts*2]) {
      funnel();
    } */
    translate([0, 0, hf*2-w]) {
      cylinder(d=t+tt*2, h=w);
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
      cylinder(d1=bd+w*2, d2=fo+w*2, h=hf+w);
    }
    translate([0, 0, -f]) {
      cylinder(d1=t+tt*2, d2=fo, h=hf+f*2);
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
  h4=h3+tl;
  translate([0,0,h3]) {
    female();
  }
  translate([-di/2+w*2.5,-w/2,h3])
    cube([di-w*5,w,tl+w]);
  translate([-w/2,-di/2+w*2.5,h3])
    cube([w,di-w*5,tl+w]);
}

module holes_lower(d,do,w=w) {
  rotate(-45) {
    translate([do/2-w*2, 0, -w/2]) {
      hole(d);
    }
  }
  rotate(180-45) {
    translate([do/2-w*2, 0, -w/2]) {
        hole(d);
    }
  }
}

module hole_upper(d,di,w=w) {
  translate([0, -di/4, 0]) {
    hole(d);
  }
}

module hole(d,w=w) {
  cube([w*4,d,w*2],center=true);
}
