//
// Stacky Peg for Board "A" template
//
// (C) 2019 Johannes Ernst.
// License: see package.
//

include <constants.scad>
include <board_A.scad>

// This peg's cylinder goes through board_A and sticks out at the
// other end, so it can be inserted into another peg
//
// hu: height units (e.g. 4 for 4 cm)
module peg_At( hu ) {
    peg_A( hu, $dz_unit );
}

// This peg's cylinder, by default, has the same length as the thickness
// of board_A, so it won't stick out
module peg_A( hu, cyl_h = $dz_unit/2, $taper=1 ) {
    h = $dz_unit * hu;

    difference() {
        cube( [ $dx_unit, $dy_unit, h + cyl_h ] );

        // see also board_A_hole

        translate( [ $dx_unit/2, $dy_unit/2, h ] )
        rotate_extrude( angle=360 ) {
            translate( [ $r1, -$eps, 0 ] ) {
                union() {
                    // go further to the right than needed: 2 * $r2 will do
                    translate( [ 0, $r2 - $r1, 0 ] ) {
                        square( [ 2 * $r2 - $r1, cyl_h + 4*$eps - ($r2 - $r1) ] );
                    }
                    translate( [ $r2 - $r1, $r2 - $r1, 0 ] ) {
                        circle( r = $r2 - $r1 );
                    }
                    translate( [ $r2 - $r1, -$eps, 0 ] ) {
                        square( [ 2 * $r2 - $r1, cyl_h + 2 * $eps ] );
                    }
                }
            }
        };

        // taper
        translate( [ $dx_unit/2, $dy_unit/2, h ] )
        rotate_extrude( angle=360 ) {
            polygon( [
                [ $r1 - $taper/2, cyl_h ],
                [ $r1, cyl_h - 1 ],
                [ $r1, cyl_h ]
            ] );
        };

        translate( [ $dx_unit/2, $dy_unit/2, -$eps ] ) {
            // make the hole extra deep -- doesn't hurt, and there will be printer leftovers
            cylinder( r = $r1, h = min( $dz_unit * 1.5, h * 0.8 ) + $eps );
        };
    }
};
