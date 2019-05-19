//
// Foot for Board "A" template
//
// (C) 2019 Johannes Ernst.
// License: see package.
//

include <constants.scad>

module foot_A( hu ) {
    h = $dz_unit * hu;

    difference() {
        cube( [ $dx_unit, $dy_unit, h ] );

        translate( [ $dx_unit/2, $dy_unit/2, -$eps ] ) {
            cylinder( r = $r1, h = h + 2*$eps );
        };
    }
};
