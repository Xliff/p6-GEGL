use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GEGL::Raw::Definitions;
use GEGL::Raw::Structs;

unit package GEGL::Raw::Matrix;

### /usr/include/gegl-0.4/gegl-matrix.h

sub gegl_matrix3_copy (GeglMatrix3 $matrix)
  returns GeglMatrix3
  is native(gegl)
  is export
{ * }

sub gegl_matrix3_copy_into (GeglMatrix3 $dst, GeglMatrix3 $src)
  is native(gegl)
  is export
{ * }

sub gegl_matrix3_determinant (GeglMatrix3 $matrix)
  returns gdouble
  is native(gegl)
  is export
{ * }

sub gegl_matrix3_equal (GeglMatrix3 $matrix1, GeglMatrix3 $matrix2)
  returns uint32
  is native(gegl)
  is export
{ * }

sub gegl_matrix3_get_type ()
  returns GType
  is native(gegl)
  is export
{ * }

sub gegl_matrix3_identity (GeglMatrix3 $matrix)
  is native(gegl)
  is export
{ * }

sub gegl_matrix3_invert (GeglMatrix3 $matrix)
  is native(gegl)
  is export
{ * }

sub gegl_matrix3_is_affine (GeglMatrix3 $matrix)
  returns uint32
  is native(gegl)
  is export
{ * }

sub gegl_matrix3_is_identity (GeglMatrix3 $matrix)
  returns uint32
  is native(gegl)
  is export
{ * }

sub gegl_matrix3_is_scale (GeglMatrix3 $matrix)
  returns uint32
  is native(gegl)
  is export
{ * }

sub gegl_matrix3_is_translate (GeglMatrix3 $matrix)
  returns uint32
  is native(gegl)
  is export
{ * }

sub gegl_matrix3_multiply (
  GeglMatrix3 $left,
  GeglMatrix3 $right,
  GeglMatrix3 $product
)
  is native(gegl)
  is export
{ * }

sub gegl_matrix3_new ()
  returns GeglMatrix3
  is native(gegl)
  is export
{ * }

sub gegl_matrix3_originate (GeglMatrix3 $matrix, gdouble $x, gdouble $y)
  is native(gegl)
  is export
{ * }

sub gegl_matrix3_parse_string (GeglMatrix3 $matrix, Str $string)
  is native(gegl)
  is export
{ * }

sub gegl_matrix3_round_error (GeglMatrix3 $matrix)
  is native(gegl)
  is export
{ * }

sub gegl_matrix3_to_string (GeglMatrix3 $matrix)
  returns Str
  is native(gegl)
  is export
{ * }

sub gegl_matrix3_transform_point (
  GeglMatrix3 $matrix,
  gdouble     $x       is rw,
  gdouble     $y       is rw
)
  is native(gegl)
  is export
{ * }
