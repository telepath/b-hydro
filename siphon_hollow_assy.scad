include <lib/siphon_hollow.scad>

/* cut_view() */
rotate([180, 0, 0]) {
  screw_siphon(di=di,do=di+w*2,fdo=fdo,h=wb,w=w);
}
