phi = (1.0+sqrt(5))/2;
s = 3;
$fn=10;


module star(dimensions, thickness) { 
    numspheres=60;
    color( [rands(0,1,1)[0], rands(0,1,1)[0], rands(0,1,1)[0]/3] )
    rotate([0,0,5])
    for(t=[0:numspheres]) {
        th = (t/numspheres) * 360;
        a = 12*sin(2*th)+5*cos(3*th);
        b = 5*sin(3*th)+12*cos(2*th);
        c = 4*cos(5*th);
        translate([a,cos(30)*b+sin(30)*c,cos(30)*c-sin(30)*b] * dimensions/13)
        sphere(r=thickness*4);
    }
}


vs = [[0.0000,1.0000,1.6180],
[0.0000,1.0000,-1.6180],
[0.0000,-1.0000,1.6180],
[0.0000,-1.0000,-1.6180]];

module link() {
    translate([0.0000,1.0000,1.6180]*phi*s)
    star(s*phi, s/10);
    
    mirror()
    translate([0,-2*phi,0]*s)
    mirror([0,1,0])
    translate([0.0000,-1.0000,1.6180]*phi*s)
    star(s*phi, s/10);
}

module rect() {
    link();
    rotate([180,0,0])
    link(s*phi, s/10);
}

module supersphere() {
    intersection() {
    sphere(r=40.0);
    
    rotate([90,0,0])
    sphere(r=40.0);
    rotate([0,90,0])
    sphere(r=40.0);
    rotate([0,0,90])
    sphere(r=40.0);
    
    rotate([60,0,0])
    sphere(r=40.0);
    rotate([0,60,0])
    sphere(r=40.0);
    rotate([0,0,60])
    sphere(r=40.0);
    }
}

cubesize=30;
lower=10;
basethick=2;


//supersphere();
difference()
{
    union()
    {
    rect();
    rotate([0,90,0])
    rotate([90,0,0])
    rect();
    rotate([0,90,0])
    rotate([90,0,0])
    rotate([0,90,0])
    rotate([90,0,0])
    rect();
    }
    translate([0,0,-lower-cubesize/2])
        cube([cubesize,cubesize,cubesize],center=true);
}

translate([0,0,-lower-basethick/2+.1])
    cylinder(r=9,h=basethick,center=true);
