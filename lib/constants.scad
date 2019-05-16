//
// Global constants for all parts
//
// (C) 2019 Johannes Ernst.
// License: see package.
//

$version = "stacky-v1"; // version identifier to be etched into parts

$fn = 64;         // smoothness

$dx_unit = 10;    // main grid unit in x direction
$dy_unit = 10;    // main grid unit in y direction
$dz_unit = 10;    // main grid unit in z direction

$r1 = 3;          // peg radius
$r2 = 5;          // radius of the end of taper of peg

$play = 0.02;     // gap between surface and nominal location so that
                  // it can move against another surface at the same
                  // nominal location
$play2 = 2*$play; // convenience constant

$eps = 0.002;     // add this to avoid numeric almost-equals
$eps2 = 2*$eps;   // convenience constant
