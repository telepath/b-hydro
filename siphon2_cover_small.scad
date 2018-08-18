include <lib/s-hydro/hydroponics.scad>
include <siphon2.scad>

/* cdi_safe=max(cdi,bd*1.25); */
h=wb;

rotate([180, 0, 0]) {
  cover_snorkel(cdi=cdi,di=di/2,cr=cr,w=w,h=wb);
}
