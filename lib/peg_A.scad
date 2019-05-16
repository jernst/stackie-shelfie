//
// Stacky Peg for Board "A" template
//
// (C) 2019 Johannes Ernst.
// License: see package.
//

include <constants.scad>
include <board_A.scad>

module peg_At( hu ) {
    peg_A( hu, $dz_unit );
}

module peg_A( hu, through_h = $dz_unit/2 ) {
    h = $dz_unit * hu;

    difference() {
        cube( [ $dx_unit, $dy_unit, h + through_h ] );

        // see also board_A_hole

        translate( [ $dx_unit/2, $dy_unit/2, h ] )
        rotate_extrude( angle=360 ) {
            translate( [ $r1, -$eps, 0 ] ) {
                union() {
                    // go further to the right than needed: 2 * $r2 will do
                    translate( [ 0, $r2 - $r1, 0 ] ) {
                        square( [ 2 * $r2 - $r1, through_h + 4*$eps - ($r2 - $r1) ] );
                    }
                    translate( [ $r2 - $r1, $r2 - $r1, 0 ] ) {
                        circle( r = $r2 - $r1 );
                    }
                    translate( [ $r2 - $r1, -$eps, 0 ] ) {
                        square( [ 2 * $r2 - $r1, through_h + 2 * $eps ] );
                    }
                }
            }
        };

        translate( [ $dx_unit/2, $dy_unit/2, -$eps ] ) {
            // make the hole extra deep -- doesn't hurt, and there will be printer leftovers
            cylinder( r = $r1, h = $dz_unit * 1.5 + $eps );
        };
    }
};
