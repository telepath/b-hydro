include <lib/siphon2.scad>
include <conf/large_config.scad>

screw_siphon();
translate([0, 0, LidHeight*2+b]) {
  %cover_snorkel();
}
