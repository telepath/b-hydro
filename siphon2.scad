include <lib/v-hydro/lib/nozzle.scad>
use <lib/Write.scad/Write.scad>
/* include <conf/large_config.scad> */

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
cdi=di*4;
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
/* module screw_siphon_nozzle() {
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
} */

module screw_siphon(w=w,h=h,t=LidHeight) {
  foot(w=w,t=t);
  siphon(do=di+w*2,di=di,h=h,w=w);
}

module foot(w=w,t=LidHeight) {
  inner_thread(l=t,w=w);
  translate([0, 0, t]) {
    difference() {
      union() {
        cylinder(d=ThreadOuterDiameter+w, h=di/3);
        translate([0, 0, di/3]) {
          cylinder(d1=ThreadOuterDiameter+w, d2=di+w*2, h=di/2);
        }
      }
      translate([0, 0, -f]) {
        /* cylinder(d1=ThreadInnerDiameter-WallThickness, d2=di, h=LidHeight+f2); */
        cylinder(d=di, h=di*1.5+f2);
      }
    }
  }
}

module holder(d=di+w*2,n=2) {
  for (i=[0:n]) {
    rotate(180/n*i-45) {
      difference() {
        rotate([90, 0, 0]) {
          cylinder(d=d*2, h=w, center=true);
        }
        cylinder(r=d*2, h=d*2);
      }
    }
  }
}

module cover_snorkel(cdi=cdi,di=di/2,cr=cr,w=w,h=h-LidHeight-b,h0=-di/2,fn=24) {
  echo("cover_snorkel",str("cdi=",cdi),str("di=",di),str("cr=",cr),str("w=",w),str("h=",h),str("fn=",fn));
  $fn=fn;
  difference() {
    union() {
      cover(h=h,cdi=cdi,r=cr,w=w);
      translate([0, 0, 0]) {
        snorkel_outer(x=cdi/2,di=di,w=w,h=h,h0=h0,$fn=fn);
      }
    }
    translate([0, 0, 0]) {
      snorkel_inner(x=cdi/2,di=di,w=w,h=h,h0=h0,$fn=fn);
    }
  }
  translate([0, 0, h+cr]) {
    holder(d=cdi/3);
  }
}

module snorkel(x=cdi/2+w/2,di=di/3,w=w*0.75,h=h,h0=-di/3) {
  difference() {
    snorkel_outer(x=x,di=di,w=w,h=h,h0=h0);
    snorkel_inner(x=x,di=di,w=w,h=h,h0=h0);
  }
}

module snorkel_outer(x=cdi/2,di=di/2,w=w,h=h,h0=-di/2) {
  do=di+w*2;
  /* h0=LidHeight; */
  //height of cup
  hc=do*2+w*2;
  translate([x, 0, 0]) {
    translate([0, 0, h0]) {
      cylinder(d=do, h=h+h0);
    }
    translate([0, 0, h+h0-w/2]) {
      sphere(d=do);
    }
    translate([w*1.5, 0, h0]) {
      difference()
      {
        cylinder(d=do+w*2, h=hc);
        translate([0, 0, w]) {
          cylinder(d=do+w, h=hc);
        }
        translate([di-w, 0, hc+h0]) {
          sphere(d=do*2);
          cylinder(d=do*4, h=hc);
        }
      }
    }
  }
}

module snorkel_inner(x=cdi/2,di=di/3,w=w*0.75,h=h,h0=-di/3) {
  do=di+w*2;
  /* h0=LidHeight; */
  translate([x, 0, 0]) {
    translate([0, 0, h0+w-f]) {
      cylinder(d=di, h=h+f2-w-h0);
    }
    translate([0, 0, h]) {
      sphere(d=di);
    }
    translate([0, 0, h-di/2+w]) {
      rotate([0, -90, 0]) {
        cylinder(d=di, h=di);
      }
    }
    translate([0, 0, di/2+w]) {
      rotate([0, 90, 0]) {
        cylinder(d=di, h=di+f*2);
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
  echo("cover",str("h=",h),str("cdi=",cdi),str("r=",r),str("w=",w));
  writecylinder(text=str(cdi,"/",h," ",MAT),where=[0,0,0],radius=cdi/2+w-0.5,height=h,rotate=-90);
  /* render() */
  difference() {
    base_hull(h=h,r=r+w,do=cdi+w*2);
    translate([0, 0, -w]) {
      base_hull(h=h+w,r=r,do=cdi);
    }
  }
}

module base_hull(h=h,r=di/2,do=di*3) {
  echo("base_hull",str("h=",h),str("r=",r),str("do=",do));
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

module siphon(do=di+w*2,di=di,h=h,w=w,fdo=fdo) {
  writecylinder(text=str(di,"/",fdo," ",MAT),where=[0,0,0],radius=do/2-0.5,height=h,rotate=-90);
  pipe_h=h-((fdo-di)/2);
  simple_pipe(do=di+w*2,di=di,h=pipe_h,w=w);
  translate([0, 0, pipe_h]) {
    funnel(di=di,do=fdo,w=w);
  }
}

module simple_pipe(do=di+w*2,di=di,h=h,w=w) {
  difference() {
    cylinder(d=do, h=h);
    translate([0, 0, -f]) {
      cylinder(d=di, h=h+f2);
    }
  }
}

module funnel(di=di,do=di*2,w=w) {
  f=w/5;
  difference() {
    intersection() {
      cylinder(d=fdo, h=(fdo-di)/2);
      torus_d(d1=fdo-di+f*2,d2=fdo);
    }
    torus_d(d1=fdo-di-w,d2=fdo+w);
  }
}

module torus_d(d1,d2){
  rotate_extrude(convexity=10) {
    translate([d2/2, 0, 0]) {
      circle(d=d1);
    }
  }
}
