include <s-hydro/BottleThread.scad>

// wall thickness
w=1.5;
// inner diameter
di=15;
// heigt (water level)
h=135;
// fine walls
f=0.01;
// double fine walls
f2=f*2;
// cover inner diameter
cdi=di*2.5;
// cover edge radius
cr=di/4;

/* ThreadOuterDiameter=di+w;
ThreadInnerDiameter=ThreadOuterDiameter-w; // Used only for cleanup. */

/* siphon(); */
/* snorkel(); */
/* foot(); */
/* translate([0, 0, LidHeight]) {
  cover_snorkel(x=cdi/2,di=di/3,cr=cr,w=w*0.75,h=h-LidHeight);
} */
/* cover_snorkel(); */

/* %screw_siphon(); */

module screw_siphon() {
  foot();
  translate([0, 0, LidHeight*2]) {
    siphon(do=di+w*2,di=di,h=h-LidHeight*2);
  }
}

module foot() {
  inner_thread();
  translate([0, 0, LidHeight]) {
    difference() {
      cylinder(d1=ThreadOuterDiameter, d2=di+w*2, h=LidHeight);
      translate([0, 0, -f]) {
        cylinder(d1=ThreadInnerDiameter-WallThickness, d2=di, h=LidHeight+f2);
      }
    }
  }
}

module holder(d=di+w*2,n=2) {
  for (i=[0:n]) {
    rotate(180/n*i) {
      difference() {
        rotate([90, 0, 0]) {
          cylinder(d=d*2, h=w, center=true);
        }
        cylinder(r=d*2, h=d*2);
      }
    }
  }
}

module cover_snorkel(x=cdi/2,di=di/3,cr=cr,w=w*0.75,h=h) {
  do=di+w*2;
  difference() {
    union() {
      cover(h=h,cdi=cdi,r=cr,w=w);
      translate([0, 0, -LidHeight+w]) {
        snorkel_outer(x=x,di=di,w=w,h=h+LidHeight-w);
      }
    }
    translate([0, 0, -LidHeight+w]) {
      snorkel_inner(x=x,di=di,w=w,h=h+LidHeight-w);
    }
  }
  translate([0, 0, h+cr]) {
    holder(d=di*2+w);
  }
}

module snorkel(x=cdi/2+w/2,di=di/3,w=w*0.75,h=h) {
  difference() {
    snorkel_outer(x=x,di=di,w=w,h=h);
    snorkel_inner(x=x,di=di,w=w,h=h);
  }
}

module snorkel_outer(x=cdi/2,di=di/3,w=w*0.75,h=h) {
  do=di+w*2;
  h0=do/2;
  translate([x, 0, 0]) {
    translate([0, 0, h0]) {
      cylinder(d=do, h=h-h0);
    }
    translate([0, 0, h]) {
      sphere(d=do);
    }
    translate([0, 0, h0]) {
      sphere(d=do);
    }
    translate([di/2, 0, h0+w]) {
      difference()
      {
        sphere(d=do+w*2);
        sphere(d=do);
        translate([di/2-w, 0, di/2]) {
          sphere(d=di+w);
        }
      }
    }
  }
}

module snorkel_inner(x=cdi/2,di=di/3,w=w*0.75,h=h) {
  do=di+w*2;
  h0=do/2;
  translate([x, 0, 0]) {
    translate([0, 0, h0-f]) {
      cylinder(d=di, h=h+f2-h0);
    }
    translate([0, 0, h]) {
      sphere(d=di);
    }
    translate([0, 0, h]) {
      rotate([0, -90, 0]) {
        cylinder(d=di+w*1.5, h=di);
      }
    }
    translate([0, 0, h0]) {
      sphere(d=di);
    }
    translate([di/2, 0, h0]) {
      sphere(d=di);
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
  translate([0, 0, h]) {
    difference() {
      torus(d1=d,d2=do-d);
      cylinder(d=do-d, h=r);
      translate([0, 0, -r]) {
        cylinder(d=do, h=r);
      }
    }
    cylinder(d=do-d, h=r);
  }
  cylinder(d=do, h=h);
}

module siphon(do=di+w*2,di=di,h=h) {
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
