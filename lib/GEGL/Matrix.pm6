use v6.c;

use Method::Also;

use GEGL::Raw::Types;
use GEGL::Raw::Matrix;

use GLib::Roles::Implementor;

# BOXED

class GEGL::Matrix {
  also does GLib::Roles::Implementor;

  has GeglMatrix3 $!gm3;

  method GEGL::Raw::Structs::GeglMatrix3
    is also<GeglMatrix3>
  { $!gm3 }

  method new {
    my $gegl-matrix = gegl_matrix3_new();

    $gegl-matrix ?? self.bless( :$gegl-matrix ) !! Nil;
  }

  submethod BUILD ( :$gegl-matrix ) {
    $!gm3 = $gegl-matrix if $gegl-matrix;
  }

  method copy ( :$raw = False ) {
    propReturnObject(
      gegl_matrix3_copy($!gm3),
      $raw,
      |GEGL::Matrix.getTypePair
    );
  }

  method copy_into (GeglMatrix3() $dst) is also<copy-into> {
    gegl_matrix3_copy_into($dst, $!gm3);
  }

  method determinant {
    gegl_matrix3_determinant($!gm3);
  }

  method equal (GeglMatrix3() $matrix2) {
    so gegl_matrix3_equal($!gm3, $matrix2);
  }

  method get_type is also<get-type> {
    state ($n, $t);
    
    unstable_get_type( self.^name, &gegl_matrix3_get_type, $n, $t );
  }

  method identity {
    gegl_matrix3_identity($!gm3);
  }

  method invert {
    gegl_matrix3_invert($!gm3);
  }

  method is_affine is also<is-affine> {
    so gegl_matrix3_is_affine($!gm3);
  }

  method is_identity is also<is-identity> {
    so gegl_matrix3_is_identity($!gm3);
  }

  method is_scale is also<is-scale> {
    so gegl_matrix3_is_scale($!gm3);
  }

  method is_translate is also<is-translate> {
    so gegl_matrix3_is_translate($!gm3);
  }

  multi method multiply (GeglMatrix3() $right, :$raw = False) {
    my $p = gegl_matrix3_new();

    GEGL::Matrix.multiply($!gm3, $right, $p, :$raw);
  }
  multi method multiply (
    GEGL::Matrix:U:

    GeglMatrix3() $left,
    GeglMatrix3() $right,
    GeglMatrix3() $product,
                  :$raw      = False
  ) {
    gegl_matrix3_multiply($left, $right, $product);

    propReturnObject(
      $product,
      $raw,
      |GEGL::Matrix.getTypePair
    );
  }

  method originate (Num() $x, Num() $y) {
    my gdouble ($xx, $yy) = ($x, $y);

    gegl_matrix3_originate($!gm3, $xx, $yy);
  }

  method parse_string (Str() $string) is also<parse-string> {
    gegl_matrix3_parse_string($!gm3, $string);
  }

  method round_error is also<round-error> {
    gegl_matrix3_round_error($!gm3);
  }

  method to_string is also<to-string> {
    gegl_matrix3_to_string($!gm3);
  }

  method transform_point (Num() $x, Num() $y) is also<transform-point> {
    my ($xx, $yy) = ($x, $y);
    self.transform_point_mutate($xx, $yy);
    ($xx, $yy);
  }

  method transform_point_mutate (Num() $x is rw, Num() $y is rw)
    is also<transform-point-mutate>
  {
    my gdouble ($xx, $yy) = ($x, $y);

    gegl_matrix3_transform_point($!gm3, $xx, $yy);
  }

}
