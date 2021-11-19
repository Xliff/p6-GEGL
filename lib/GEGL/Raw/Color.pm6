use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Enums;
use GLib::Raw::Structs;
use GEGL::Raw::Definitions;

unit package GEGL::Raw::Coplor;

### /usr/include/gegl/gegl-color.h

sub gegl_color_duplicate (GeglColor $color)
  returns GeglColor
  is native(gegl)
  is export
{ * }

sub gegl_param_color_get_type ()
  returns GType
  is native(gegl)
  is export
{ * }

sub gegl_param_spec_color (
  Str         $name,
  Str         $nick,
  Str         $blurb,
  GeglColor   $default_color,
  GParamFlags $flags
)
  returns GParamSpec
  is native(gegl)
  is export
{ * }

sub gegl_param_spec_color_from_string (
  Str         $name,
  Str         $nick,
  Str         $blurb,
  Str         $default_color_string,
  GParamFlags $flags
)
  returns GParamSpec
  is native(gegl)
  is export
{ * }

sub gegl_param_spec_color_get_default (GParamSpec $self)
  returns GeglColor
  is native(gegl)
  is export
{ * }

sub gegl_color_get_format (GeglColor $color)
  returns Babl
  is native(gegl)
  is export
{ * }

sub gegl_color_get_pixel (GeglColor $color, Babl $format, Pointer $pixel)
  is native(gegl)
  is export
{ * }

sub gegl_color_get_rgba (
  GeglColor $color,
  gdouble   $red   is rw,
  gdouble   $green is rw,
  gdouble   $blue  is rw,
  gdouble   $alpha is rw
)
  is native(gegl)
  is export
{ * }

sub gegl_color_get_type ()
  returns GType
  is native(gegl)
  is export
{ * }

sub gegl_color_new (Str $string)
  returns GeglColor
  is native(gegl)
  is export
{ * }

sub gegl_color_set_pixel (GeglColor $color, Babl $format, Pointer $pixel)
  is native(gegl)
  is export
{ * }

sub gegl_color_set_rgba (
  GeglColor $color,
  gdouble   $red,
  gdouble   $green,
  gdouble   $blue,
  gdouble   $alpha
)
  is native(gegl)
  is export
{ * }
