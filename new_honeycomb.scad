// (in millimeters)
sideWidth = 20; 
baseHeight = 20;
reservoirDepth = 5;
reservoirOffset = baseHeight - reservoirDepth;
reservoirWidth = 2;
// hexagon computations
diameter = 2 * sideWidth;
minimalRadius = cos(30) * sideWidth;
perimeter = 6 * sideWidth;
area = (minimalRadius * perimeter) / 2;

// Draw
difference() {
linear_extrude(height = baseHeight, convexity = 10, twist = 0)
    translate([0,0]) polygonWithArea(6, sideWidth);
 reservoir();
}

// One shape with corresponding text
module polygonWithArea(points, r) {
    polygon(ngon(points, r));
}

// List comprehension for creating N-gon vertices
function ngon(num, r) = 
  [for (i=[0:num-1], a=i*360/num) [ r*cos(a), r*sin(a) ]];

// reservoirs
module reservoir() {
    translate([0,0, reservoirOffset]) linear_extrude(height = baseHeight, convexity = 10, twist = 0) polygonWithArea(6, reservoirWidth);
}
  
// function to compute coordinate pairs for reservoirs (hexagon base only)

// twist lock - "Principles of Interlocking"
  
// stand
  
// evaporation computation
  
// size computations

