include <s-hydro/hydroponics.scad>

z = 150;                     //box height

xd = 2;                     //number of x planters
yd = 2;                     //number of y planters

wt = 20;                    //water level from top

sq=0;                       //square
rn=1;                       //round

// wall thickness
w=1.5;

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

// Thread parameters
/* ThreadInnerDiameter=15;
ThreadOuterDiameter=ThreadInnerDiameter+WallThickness*2; */

bd = ThreadOuterDiameter;
