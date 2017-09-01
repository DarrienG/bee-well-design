// (in millimeters)
sideWidth = 200; 
baseHeight = 20;
reservoirDepth = 5;
reservoirOffset = baseHeight - reservoirDepth;
reservoirWidth = 10;
// hexagon computations
diameter = 2 * sideWidth;
minimalRadius = cos(30) * sideWidth;
perimeter = 6 * sideWidth;
area = (minimalRadius * perimeter) / 2;

// Draw
difference() {
linear_extrude(height = baseHeight, convexity = 10, twist = 0)
    rotate(180) translate([0,0]) polygonWithArea(6, sideWidth);
    createTiles(reservoirWidth, 1, minimalRadius);
}

// One shape with corresponding text
module polygonWithArea(points, r) {
    polygon(ngon(points, r));
}

// List comprehension for creating N-gon vertices
function ngon(num, r) = 
  [for (i=[0:num-1], a=i*360/num) [ r*cos(a), r*sin(a) ]];

// reservoirs
module reservoir(x, y) {
    translate([x, y, reservoirOffset]) linear_extrude(height = baseHeight, convexity = 10, twist = 0) polygonWithArea(6, reservoirWidth);
}
  
// Creates tiled set of shapes over a parent 
module createTiles(childCircumradius, childPadding, parentInRadius) {
    distBetween = childCircumradius * 2 + childPadding * 2;
    numTilesY = parentInRadius / distBetween;
    echo("These are my vals: ", numTilesY, distBetween);
    for (multiplier = [0:1:numTilesY]) {
        for (xVal = [0:distBetween:computeXDist(parentInRadius, distBetween * multiplier)]) {
            reservoir(xVal, distBetween * multiplier);
            reservoir(xVal, -distBetween * multiplier);
            reservoir(-xVal, distBetween * multiplier);  
            reservoir(-xVal, -distBetween * multiplier);
        }
    }
}

function computeXDist(objectRadius, offset) = computeChordDistance(objectRadius, offset) / 2;

// Calculate the distance from a point on the circle (offset by x or y) to the edge of the given circle * 2. 
// See: https://www.ajdesigner.com/phpcircle/circle_arc_length_theta.php
// @param objectRadius Radius of parent object
// @param offset Distance from origin. Either x or y, but not both.
function computeChordDistance(objectRadius, offset) = 2 * sqrt(pow(objectRadius, 2) - pow(offset, 2));

// twist lock - "Principles of Interlocking"
  
// stand
  
// evaporation computation
  
// size computations

