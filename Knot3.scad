c = [
[0.9, 0.2, 0.2],
[0.4, 0.8, 0.1],
[0.1, 0.5, 0.7],
[0.9, 0.7, 0.1],
[1.0, 0.5, 0.7],
[0.1, 0.5, 0.0]
];

res = 200;

for(num_loops=[2:7]) {
    color(c[num_loops-2])
    for(a=[1:num_loops-1]) {
        b = num_loops-a;
        translate([a*40 - num_loops*20,num_loops*40,0])
        rotate([0,b==a ? 90 : 0,b==a ? 90 : 0])
        for(t=[0:res*num_loops]) {
            th = (t/(res*num_loops)) * 360;
            translate([12*sin(a*th)+5*cos(b*th),
                       5*sin(b*th)+12*cos(a*th),
                       7*cos(num_loops*th)])
            sphere(r=2.0);
        }
    }
}
