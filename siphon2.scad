// wall thickness
w=1.5;
// inner diameter
di=15;
// heigt (water level)
h=50;
// fine walls
f=0.01;
// double fine walls
f2=f*2;
// cover inner diameter
cdi=di*2.5;
// cover edge radius
cr=di/4;

/* siphon(); */
/* base_hull(); */
/* %cover();
snorkel(); */
cover_snorkel();

module cover_snorkel() {
  difference() {
    union() {
      %cover();
      snorkel_outer();
    }
    snorkel_inner();
  }
}

module snorkel(x=cdi/2+w/2,di=di/3,w=w*0.75,h=h) {
    difference() {
      snorkel_outer(x=x,di=di,w=w,h=h);
      snorkel_inner(x=x,di=di,w=w,h=h);
    }
    /* pipe(do=di+w*2, di=di, h=h); */
}

module snorkel_outer(x=cdi/2+w/2,di=di/3,w=w*0.75,h=h) {
  translate([x, 0, 0]) {
    cylinder(d=di+w*2, h=h);
    translate([0, 0, h]) {
      sphere(d=di+w*2);
    }
  }
}

module snorkel_inner(x=cdi/2+w/2,di=di/3,w=w*0.75,h=h) {
  translate([x, 0, 0]) {
    translate([0, 0, -f]) {
      cylinder(d=di, h=h+f2);
    }
    translate([0, 0, h]) {
      sphere(d=di);
    }
    translate([0, 0, h]) {
      rotate([0, -90, 0]) {
        cylinder(d=di+w*1.5, h=di);
      }
    }
  }
}

module cover(h=h+di/2,cdi=cdi,r=cr,w=w) {
  /* render() */
  difference() {
    base_hull(h=h,r=r+w,do=cdi+w*2);
    translate([0, 0, -w]) {
      base_hull(h=h+w,r=r,do=cdi);
    }
  }
}

module base_hull(h=h,r=di/2,do=di*3) {
  d=r*2;
  translate([0, 0, h-di/2]) {
    difference() {
      torus(d1=d,d2=do-d);
      cylinder(d=do-d, h=r);
      translate([0, 0, -r]) {
        cylinder(d=do, h=r);
      }
    }
    cylinder(d=do-d, h=r);
  }
  cylinder(d=do, h=h-di/2);
}

module siphon() {
  pipe(do=di+w*2,di=di,h=h-di/2);
  translate([0, 0, h-di/2]) {
    funnel(di);
  }
}

module pipe(do=di+w*2,di=di,h=h) {
  difference() {
    cylinder(d=do, h=h);
    translate([0, 0, -f]) {
      cylinder(d=di, h=h+f2);
    }
  }
}

module funnel(di) {
  difference() {
    intersection() {
      cylinder(r=di, h=di);
      torus(di,di*2);
    }
      torus(di-w,di*2+w);
  }
}

module torus(d1,d2){
  rotate_extrude(convexity=10) {
    translate([d2/2, 0, 0]) {
      circle(d=d1);
    }
  }
}
