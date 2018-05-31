include <siphon2.scad>
include <large_config.scad>

rotate([180, 0, 0]) {
  cover_snorkel(cdi=cdi,di=di/2,cr=cr,w=w,h=h-LidHeight);
}
