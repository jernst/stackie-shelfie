//
// Stacky X-Peg for Board "A" template
//
// (C) 2019 Johannes Ernst.
// License: see package.
//

include <constants.scad>
include <peg_A.scad>
include <josl/bezier/bezier.scad>

// This peg's cylinder goes through board_A and sticks out at the
// other end, so it can be inserted into another peg
//
// xu, yu, zu: x/y/z units (e.g. 4 for 4 cm)
module xpeg_At( xu, yu, zu, hole_h = $dz_unit * 1.5, taper = 1  ) {
    xpeg_A( xu, yu, zu, $dz_unit, hole_h = hole_h, taper = taper );
}

// This peg's cylinder, by default, has the same length as the thickness
// of board_A, so it won't stick out
module xpeg_A( xu, yu, zu, cyl_h = $dz_unit/2, hole_h = $dz_unit * 1.5, taper = 1, bezier_stretch = 3 ) {
    h = $dz_unit * zu;

    for( ix = [0, ceil(xu)-1] ) {
         for( iy = [0:ceil(yu)-1] ) {
            translate( [ $dx_unit * ix, $dy_unit * iy, 0 ] ) {
                    // make the hole extra deep -- doesn't hurt, and there will be printer leftovers
               difference() {
                    cube( [ $dx_unit, $dy_unit, $dz_unit ] );

                    translate( [ $dx_unit/2, $dy_unit/2, -$eps ] ) {
                        // make the hole extra deep -- doesn't hurt, and there will be printer leftovers
                        cylinder( r = $r1, h = min( hole_h, h * 0.8 ) + $eps );
                    };
                };
            };
        };
    };

    translate( [ xu *$dz_unit / 2, 0, 0 ] ) {
        xpeg_A_branch( xu, yu, zu, bezier_stretch );
        mirror( [ 1, 0, 0 ] ) {
            xpeg_A_branch( xu, yu, zu, bezier_stretch );
        }
    };

    for( ix = [0, ceil(xu)-1] ) {
        for( iy = [0:ceil(yu)-1] ) {
            translate( [ $dx_unit * ix , $dy_unit * iy, h ] ) {
                peg_A_cylinder( cyl_h, taper );
            }
        };
    }
};


module xpeg_A_branch( xu, yu, zu, bezier_stretch ) {
    translate( [ - xu *$dz_unit / 2, $dy_unit, 0 ] )
    rotate( 90, [ 1, 0, 0 ] )
    linear_extrude( yu * $dy_unit ) {
        polygon( bezier_curve_seq_inclusive(
        [
            [ 0,                 $dz_unit ],
            [ (xu-1) * $dx_unit, zu * $dz_unit ],
            [  xu    * $dx_unit, zu * $dz_unit ],
            [ $dx_unit,          $dz_unit ]
        ],
        [
            [
                [ 0, $dz_unit + $dz_unit * bezier_stretch ],
                [ (xu-1) * $dx_unit, zu * $dz_unit - $dz_unit * bezier_stretch ]
            ],
            [],
            [
                [ xu * $dx_unit, zu * $dz_unit - $dz_unit * bezier_stretch ],
                [ $dx_unit, $dz_unit + $dz_unit * bezier_stretch ]
            ],
            []            
       ] ));
    };
};
