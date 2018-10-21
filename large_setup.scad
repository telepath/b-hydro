include <boxInset_large.scad>
include <lib/siphon2.scad>

display();

module display() {
  rotate(90) {
    translate([(d+b)*(xd-1)/2,(d+b)*shift, 0]) {
      screw_siphon(dhex=SW36);
      translate([0, 0, LidHeight*2+b]) {
        cover_snorkel();
      }
    }
  }
}
