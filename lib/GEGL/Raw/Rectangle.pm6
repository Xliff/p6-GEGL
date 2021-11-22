use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GEGL::Raw::Definitions;
use GEGL::Raw::Enums;

unit package GEGL::Raw::Rectangle;

### /usr/include/gegl-0.4/gegl-rectangle.h

sub _gegl_float_epsilon_equal (gfloat $v1, gfloat $v2)
  returns gint
  is native(gegl)
  is export
{ * }

sub _gegl_float_epsilon_zero (gfloat $value)
  returns gint
  is native(gegl)
  is export
{ * }

sub gegl_rectangle_align (
  GeglRectangle          $destination,
  GeglRectangle          $rectangle,
  GeglRectangle          $tile,
  GeglRectangleAlignment $alignment
)
  returns uint32
  is native(gegl)
  is export
{ * }

sub gegl_rectangle_align_to_buffer (
  GeglRectangle          $destination,
  GeglRectangle          $rectangle,
  GeglBuffer             $buffer,
  GeglRectangleAlignment $alignment
)
  returns uint32
  is native(gegl)
  is export
{ * }

sub gegl_rectangle_bounding_box (
  GeglRectangle $destination,
  GeglRectangle $source1,
  GeglRectangle $source2
)
  is native(gegl)
  is export
{ * }

sub gegl_rectangle_contains (GeglRectangle $parent, GeglRectangle $child)
  returns uint32
  is native(gegl)
  is export
{ * }

sub gegl_rectangle_copy (GeglRectangle $destination, GeglRectangle $source)
  is native(gegl)
  is export
{ * }

sub gegl_rectangle_dump (GeglRectangle $rectangle)
  is native(gegl)
  is export
{ * }

sub gegl_rectangle_dup (GeglRectangle $rectangle)
  returns GeglRectangle
  is native(gegl)
  is export
{ * }

sub gegl_rectangle_equal (GeglRectangle $rectangle1, GeglRectangle $rectangle2)
  returns uint32
  is native(gegl)
  is export
{ * }

sub gegl_rectangle_equal_coords (
  GeglRectangle $rectangle,
  gint          $x,
  gint          $y,
  gint          $width,
  gint          $height
)
  returns uint32
  is native(gegl)
  is export
{ * }

sub gegl_rectangle_get_type ()
  returns GType
  is native(gegl)
  is export
{ * }

sub gegl_rectangle_infinite_plane ()
  returns GeglRectangle
  is native(gegl)
  is export
{ * }

sub gegl_rectangle_intersect (
  GeglRectangle $dest,
  GeglRectangle $src1,
  GeglRectangle $src2
)
  returns uint32
  is native(gegl)
  is export
{ * }

sub gegl_rectangle_is_empty (GeglRectangle $rectangle)
  returns uint32
  is native(gegl)
  is export
{ * }

sub gegl_rectangle_is_infinite_plane (GeglRectangle $rectangle)
  returns uint32
  is native(gegl)
  is export
{ * }

sub gegl_rectangle_new (gint $x, gint $y, guint $width, guint $height)
  returns GeglRectangle
  is native(gegl)
  is export
{ * }

sub gegl_rectangle_set (
  GeglRectangle $rectangle,
  gint          $x,
  gint          $y,
  guint         $width,
  guint         $height
)
  is native(gegl)
  is export
{ * }

sub gegl_rectangle_subtract (
  GeglRectangle $destination,
  GeglRectangle $minuend,
  GeglRectangle $subtrahend
)
  returns gint
  is native(gegl)
  is export
{ * }

sub gegl_rectangle_subtract_bounding_box (
  GeglRectangle $destination,
  GeglRectangle $minuend,
  GeglRectangle $subtrahend
)
  returns uint32
  is native(gegl)
  is export
{ * }

sub gegl_rectangle_xor (
  GeglRectangle $destination,
  GeglRectangle $source1,
  GeglRectangle $source2
)
  returns gint
  is native(gegl)
  is export
{ * }
