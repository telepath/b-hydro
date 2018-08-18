include <lib/siphon2.scad>
include <conf/large_config.scad>

hoseThickness=1.5;

nozzle_cap(di=ndo*1.2+hoseThickness*2,do=ndo*1.2+hoseThickness*2+w*4,l=ndo*2);
