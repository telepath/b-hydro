include <v-hydro/lib/nozzle.scad>
/* include <large_config.scad> */

// wall thickness
w=1.5;
f=0.01;

//// SIPHON
// inner diameter
di=10;
// funnel outer diameter
fdo=30;
// heigt (water level)
h=135;
// double fine walls
f2=f*2;
// cover inner diameter
cdi=di*2.5;
// cover edge radius
cr=di/4;
// nozzle outer diameter
ndo=8;

/* ThreadOuterDiameter=di+w;
ThreadInnerDiameter=ThreadOuterDiameter-w; // Used only for cleanup. */

/* siphon(); */
/* snorkel(); */
/* foot(); */
/* translate([0, 0, LidHeight]) {
  cover_snorkel(x=cdi/2,di=di/2,cr=cr,w=w,h=h-LidHeight);
} */
/* cover_snorkel(); */

/* screw_siphon(); */

/* screw_siphon_nozzle(); */
module screw_siphon_nozzle() {
  l=LidHeight*2;
  foot();
  translate([0, 0, LidHeight]) {
    siphon(do=di+w*2,di=di,h=h-LidHeight);
  }
  translate([0, 0, -l+LidHeight]) {
    difference() {
      nozzle(l=l,do=ndo,di=ndo-w*2,n1=w/2,n2=ndo-di-w/2);
      translate([0, 0, l-l/5]) {
        cylinder(d1=ndo-w*2, d2=di, h=l/5+f);
      }
    }
  }
}

module screw_siphon() {
  foot();
  siphon(do=di+w*2,di=di,h=h);
}

module foot() {
  inner_thread();
  translate([0, 0, LidHeight]) {
    difference() {
      union() {
        cylinder(d=ThreadOuterDiameter+w, h=LidHeight/2);
        translate([0, 0, LidHeight/2]) {
          cylinder(d1=ThreadOuterDiameter+w, d2=di+w*2, h=LidHeight);
        }
      }
      translate([0, 0, -f]) {
        /* cylinder(d1=ThreadInnerDiameter-WallThickness, d2=di, h=LidHeight+f2); */
        cylinder(d=di, h=LidHeight*1.5+f2);
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

module cover_snorkel(x=cdi/2,di=di/3,cr=cr,w=w,h=h-LidHeight-b,fn=24) {
  $fn=fn;
  difference() {
    union() {
      cover(h=h,cdi=cdi,r=cr,w=w);
      translate([0, 0, 0]) {
        snorkel_outer(x=x,di=di,w=w,h=h,$fn=fn);
      }
    }
    translate([0, 0, 0]) {
      snorkel_inner(x=x,di=di,w=w,h=h,$fn=fn);
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

module snorkel_outer(x=cdi/2,di=di/2,w=w,h=h) {
  do=di+w*2;
  h0=0;
  //height of cup
  hc=do*2+w*2;
  translate([x, 0, 0]) {
    translate([0, 0, h0]) {
      cylinder(d=do, h=h-h0);
    }
    translate([0, 0, h]) {
      sphere(d=do);
    }
    translate([do/2-w*1.5, 0, -di]) {
      difference()
      {
        cylinder(d=do+w*2, h=hc);
        translate([0, 0, w]) {
          cylinder(d=do+w, h=hc);
        }
        translate([di-w, 0, hc-w]) {
          sphere(d=do*2);
        }
      }
    }
  }
}

module snorkel_inner(x=cdi/2,di=di/3,w=w*0.75,h=h) {
  do=di+w*2;
  h0=0;
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
    /* translate([0, 0, h0]) {
      sphere(d=di);
    } */
    /* translate([di/2, 0, h0]) {
      #sphere(d=di+w);
    } */
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
      torus_d(d1=d,d2=do-d);
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
  simple_pipe(do=di+w*2,di=di,h=h-di/2);
  translate([0, 0, h-di/2]) {
    funnel(di=di,do=fdo);
  }
}

module simple_pipe(do=di+w*2,di=di,h=h) {
  difference() {
    cylinder(d=do, h=h);
    translate([0, 0, -f]) {
      cylinder(d=di, h=h+f2);
    }
  }
}

module funnel(di=di,do=di*2) {
  difference() {
    intersection() {
      cylinder(d=fdo, h=di);
      torus_d(do/2,di+do/2);
    }
      torus_d(do/2-w,di+do/2+w);
  }
}

module torus_d(d1,d2){
  rotate_extrude(convexity=10) {
    translate([d2/2, 0, 0]) {
      circle(d=d1);
    }
  }
}
