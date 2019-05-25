//
// Foot for Board "A" template
//
// (C) 2019 Johannes Ernst.
// License: see package.
//

include <constants.scad>

module foot_A( xu, yu, zu ) {
    h = $dz_unit * zu;

    difference() {
        cube( [ xu * $dx_unit, yu * $dy_unit, h ] );

        for( ix = [0:xu-1] ) {
            for( iy = [0:yu-1] ) {
                translate( [ $dx_unit * ix + $dx_unit/2, $dy_unit * iy + $dy_unit/2, -$eps ] ) {
                    cylinder( r = $r1, h = h + 2 * $eps );
                };
            };
        };

    }
};

