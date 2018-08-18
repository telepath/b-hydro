include <lib/v-hydro/lib/nozzle.scad>
include <conf/large_config.scad>

z=100;
l=tl*2;
//nozzle height
hn=ndo*1.5;

finish_outlet();

module finish_outlet() {
  difference() {
    union() {
      finish();
      tank_inner();
      outlet_outer();
    }
    outlet_inner();
  }
}

module outlet_inner(d=ndo-w*2) {
  translate([0, x/2, hn]) {
    rotate([90, 0, 0]) {
      cylinder(d=d, h=l, center=true);
    }
  }
}

module outlet_outer() {
  translate([0, x/2+l-b/2, hn]) {
    rotate([90, 0, 0]) {
      nozzle(l=l,do=ndo,di=ndo-w*2,n1=w/2,n2=-w,$fn=12);
    }
  }
}
