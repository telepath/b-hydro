use <v-hydro/connector.scad>

do = 9;		//outer diameter of the connector/nozzle (plus nozzle ridges)
di = 6;		//innter diameter of the connector/nozzle

$fn=12;

printable(do=do*0.95){
  nConnector(do=do,di=di,l=do*2,n=3,n1=0.5);
}
