use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GEGL::Raw::Definitions;

unit package GEGL::Raw::Curve;

### /usr/include/gegl-0.4/gegl-curve.h

sub gegl_curve_add_point (GeglCurve $curve, gdouble $x, gdouble $y)
  returns guint
  is native(gegl)
  is export
{ * }

sub gegl_curve_calc_value (GeglCurve $curve, gdouble $x)
  returns gdouble
  is native(gegl)
  is export
{ * }

sub gegl_curve_calc_values (
  GeglCurve       $curve,
  gdouble         $x_min,
  gdouble         $x_max,
  guint           $num_samples,
  CArray[gdouble] $xs,
  CArray[gdouble] $ys
)
  is native(gegl)
  is export
{ * }

sub gegl_curve_duplicate (GeglCurve $curve)
  returns GeglCurve
  is native(gegl)
  is export
{ * }

sub gegl_param_curve_get_type ()
  returns GType
  is native(gegl)
  is export
{ * }

sub gegl_param_spec_curve (
  Str         $name,
  Str         $nick,
  Str         $blurb,
  GeglCurve   $default_curve,
  GParamFlags $flags
)
  returns GParamSpec
  is native(gegl)
  is export
{ * }

sub gegl_curve_get_point (
  GeglCurve $curve,
  guint     $index,
  gdouble   $x      is rw,
  gdouble   $y      is rw
)
  is native(gegl)
  is export
{ * }

sub gegl_curve_get_type ()
  returns GType
  is native(gegl)
  is export
{ * }

sub gegl_curve_get_y_bounds (
  GeglCurve $curve,
  gdouble   $min_y is rw,
  gdouble   $max_y is rw
)
  is native(gegl)
  is export
{ * }

sub gegl_curve_new (gdouble $y_min, gdouble $y_max)
  returns GeglCurve
  is native(gegl)
  is export
{ * }

sub gegl_curve_new_default ()
  returns GeglCurve
  is native(gegl)
  is export
{ * }

sub gegl_curve_num_points (GeglCurve $curve)
  returns guint
  is native(gegl)
  is export
{ * }

sub gegl_curve_set_point (
  GeglCurve $curve,
  guint     $index,
  gdouble   $x,
  gdouble   $y
)
  is native(gegl)
  is export
{ * }
