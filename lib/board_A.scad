//
// Stacky Board "A" template
//
// (C) 2019 Johannes Ernst.
// License: see package.
//

include <constants.scad>

module board_A( xu, yu ) {
    h = $dz_unit/2;

    difference() {
        translate( [ $play, $play, $play ] ) {
            cube( [ xu * $dx_unit - $play2 , yu * $dy_unit - $play2, h - $play2 ] );
        }

        for( ix = [ 0 : xu-1 ] ) {
            for( iy = [ 0 : yu-1 ] ) {
                translate( [ ix * $dx_unit + $dx_unit/2, iy * $dy_unit + $dy_unit/2, -$eps ] ) { // works even if $play=0
                     board_A_hole( h );
                }
            }
        }
    }
}

module board_A_hole( h ) {
    // see also peg_A
    render()
    difference() {
        cylinder( h = h + $eps2, r = $r2 + ( $r2 - $r1 ) );

        rotate_extrude( angle=360 ) {
            translate( [ $r1, -$eps, 0 ] ) {
                union() {
                    square( [ $r2 + ( $r2 - $r1 ), h + 4*$eps - ($r2 - $r1) ] );
                    translate( [ $r2 - $r1, h + 2*$eps - ($r2 -$r1), 0 ] ) {
                        circle( r = $r2 - $r1 );
                    }
                    translate( [ $r2 - $r1, -$eps, 0 ] ) {
                        square( [ $r2 + $r2 - $r1, h + 2 * $eps ] );
                    }
                }
            }
        }
    }
}
