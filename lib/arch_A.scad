//
// Stacky Arch for Board "A" template
//
// (C) 2019 Johannes Ernst.
// License: see package.
//

include <constants.scad>
include <peg_A.scad>

// This arch's cylinder goes through board_A and sticks out at the
// other end, so it can be inserted into another peg
//
// xu, yu, zu: x/y/z units (e.g. 4 for 4 cm)
module arch_At( xu, yu, zu, taper = 1  ) {
    arch_A( xu, yu, zu, $dz_unit, taper = taper );
}

// This arch's cylinder, by default, has the same length as the thickness
// of board_A, so it won't stick out
module arch_A( xu, yu, zu, cyl_h = $dz_unit/2, taper = 1, ru = 3, czu = 2.4 ) {

    x_in = $dz_unit * ( ru - sqrt( ru * ru - czu * czu ));

    // bottom horizontal
    translate( [ x_in + $eps, 0, 0 ] ) {
        cube( [ xu * $dx_unit - 2*x_in - 2*$eps, yu * $dy_unit, $dz_unit ] );
    }

    // left curve
    difference() {
        arch_A_trough( yu * $dy_unit, ru * $dz_unit, czu * $dz_unit );
        translate( [ $dx_unit, -$eps, 0 ] ) {
            arch_A_trough( yu * $dy_unit + 2*$eps, (ru-1) * $dz_unit, czu * $dz_unit );
        }
    }

    // right curve
    translate( [ xu * $dx_unit, 0, 0 ] )
    mirror( [ 1, 0, 0 ] )
    difference() {
        arch_A_trough( yu * $dy_unit, ru * $dz_unit, czu * $dz_unit );
        translate( [ $dx_unit, -$eps, 0 ] ) {
            arch_A_trough( yu * $dy_unit + 2*$eps, (ru-1) * $dz_unit, czu * $dz_unit );
        }
    }

    // left post
    translate( [ 0, 0, czu * $dz_unit] ) {
        cube( [ $dx_unit, $dy_unit, ( zu - czu ) * $dz_unit] );
    }
    translate( [ 0, 0, zu * $dz_unit] ) {
        peg_A_cylinder( cyl_h, taper );
    }

    // right post
    translate( [ (xu-1) * $dx_unit, 0, czu * $dz_unit] ) {
        cube( [ $dx_unit, $dy_unit, ( zu - czu ) * $dz_unit] );
    }
    translate( [ (xu-1) * $dx_unit, 0, zu * $dz_unit] ) {
        peg_A_cylinder( cyl_h, taper );
    }
}

module arch_A_trough( y, r, cz ) {
    intersection() {
        cube( [ r, y, cz ] );

        translate( [ r, y, cz ] )
        rotate( 90, [ 1, 0, 0 ] ) {
            cylinder( r = r, h = y );
        }
    }
}
