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
// xu, yu, zu: x/y/z units (e.g. 4 for 4 cm)
module peg_At( xu, yu, zu, hole_h = $dz_unit * 1.5, taper = 1  ) {
    peg_A( xu, yu, zu, $dz_unit, hole_h = hole_h, taper = taper );
}

// This peg's cylinder, by default, has the same length as the thickness
// of board_A, so it won't stick out
module peg_A( xu, yu, zu, cyl_h = $dz_unit/2, hole_h = $dz_unit * 1.5, taper = 1 ) {
    h = $dz_unit * zu;

    difference() {
        cube( [ $dx_unit * xu, $dy_unit * yu, h ] );

        for( ix = [0:ceil(xu)-1] ) {
            for( iy = [0:ceil(yu)-1] ) {
                translate( [ $dx_unit * ix + $dx_unit/2, $dy_unit * iy + $dy_unit/2, -$eps ] ) {
                    // make the hole extra deep -- doesn't hurt, and there will be printer leftovers
                    cylinder( r = $r1, h = min( hole_h, h * 0.8 ) + $eps );
                };
            };
        };
    };

    for( ix = [0:ceil(xu)-1] ) {
        for( iy = [0:ceil(yu)-1] ) {
            translate( [ $dx_unit * ix , $dy_unit * iy, h ] ) {
                peg_A_cylinder( cyl_h, taper );
            }
        };
    }
};

module peg_A_cylinder( cyl_h, taper ) {
    difference() {
        // see also board_A_hole
        cube( [ $dx_unit, $dy_unit, cyl_h ] );

        translate( [ $dx_unit/2, $dy_unit/2, 0 ] )
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
        }

        // taper
        translate( [ $dx_unit/2, $dy_unit/2, 0 ] )
        rotate_extrude( angle=360 ) {
            polygon( [
                [ $r1 - taper/2, cyl_h ],
                [ $r1, cyl_h - 1 ],
                [ $r1, cyl_h ]
            ] );
        };
    }
}
