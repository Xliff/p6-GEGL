use v6.c;

use Method::Also;

use NativeCall;

use GEGL::Raw::Types;
use GEGL::Raw::Curve;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

our subset GeglCurveAncestry is export of Mu
  where GeglCurve | GObject;

class GEGL::Curve {
  also does GLib::Roles::Object;
  also does GLib::Roles::Implementor;

  has GeglCurve $!gc is implementor;

  submethod BUILD ( :$gegl-curve ) {
    self.setGeglCurve($gegl-curve) if $gegl-curve;
  }

  method setGeglCurve (GeglCurveAncestry $_) {
    my $to-parent;

    $!gc = do {
      when GeglCurve {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GeglCurve, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GEGL::Raw::Definitions::GeglCurve
    is also<GeglCurve>
  { $!gc }

  multi method new (GeglCurveAncestry $gegl-curve, :$ref = True) {
    return Nil unless $gegl-curve;

    my $o = self.bless(:$gegl-curve);
    $o.ref if $ref;
    $o;
  }
  multi method new (Num() $y_min, Num() $y_max) {
    my gdouble ($y1, $y2)   = ($y_min, $y_max);
    my          $gegl-curve = gegl_curve_new($y1, $y2);

    $gegl-curve ?? self.bless( :$gegl-curve ) !! Nil
  }

  method new_default is also<new-default> {
    my $gegl-curve = gegl_curve_new_default();

    $gegl-curve ?? self.bless( :$gegl-curve ) !! Nil
  }

  method add_point (Num() $x, Num() $y) is also<add-point> {
    my gdouble ($xx, $yy) = ($x, $y);

    gegl_curve_add_point($!gc, $xx, $yy);
  }

  method calc_value (Num() $x) is also<calc-value> {
    gegl_curve_calc_value($!gc, $x);
  }

  proto method calc_values (|)
    is also<calc-values>
  { * }

  multi method calc_values (
    Num()           $x_min,
    Num()           $x_max,
    Int()           $num_samples,
                    :$raw         = False,
                    :$points      = False
  ) {
    my ($xs, $ys) = CArray.allocate($num_samples) xx 2;

    samewith($x_min, $x_max, $num_samples, $xs, $ys);
    return ($xs, $ys) if $raw;
    ($xs, $ys) = ( CArrayToArray($xs), CArrayToArray($ys) );
    return ($xs, $ys) unless $points;
    $xs [Z] $ys
  }
  multi method calc_values (
    Num()           $x_min,
    Num()           $x_max,
    Int()           $num_samples,
    CArray[gdouble] $xs,
    CArray[gdouble] $ys
  ) {
    my gdouble ($x1, $x2) = ($x_min, $x_max);
    my guint   $n         = $num_samples;

    die '$xs is not large enough to hold all values' unless $xs.elems >= $n;
    die '$ys is not large enough to hold all values' unless $ys.elems >= $n;

    gegl_curve_calc_values($!gc, $x1, $x2, $n, $xs, $ys);
  }

  method duplicate ( :$raw = False ) {
    propReturnObject(
      gegl_curve_duplicate($!gc),
      $raw,
      |self.getTypePair
    )
  }

  # method gegl_param_curve_get_type {
  #   gegl_param_curve_get_type();
  # }

  # method gegl_param_spec_curve (
  #   Str         $nick,
  #   Str         $blurb,
  #   GeglCurve   $default_curve,
  #   GParamFlags $flags
  # ) {
  #   gegl_param_spec_curve($!gc, $nick, $blurb, $default_curve, $flags);
  # }

  proto method get_point (|)
    is also<get-point>
  { * }

  multi method get_point (Int() $index) {
    samewith($, $);
  }
  multi method get_point (Int() $index, $x is rw, $y is rw) {
    my guint $i;
    my gdouble ($xx, $yy) = 0e0 xx 2;

    gegl_curve_get_point($!gc, $i, $xx, $yy);
    ($x, $y) = ($xx, $yy);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gegl_curve_get_type, $n, $t );
  }

  proto method get_y_bounds (|)
    is also<get-y-bounds>
  { * }

  multi method get_y_bounds {
    samewith($, $);
  }
  multi method get_y_bounds ($min_y is rw, $max_y is rw) {
    my gdouble ($y1, $y2) = 0e0 xx 2;

    gegl_curve_get_y_bounds($!gc, $y1, $y2);
    ($min_y, $max_y) = ($y1, $y2);
  }

  method num_points is also<num-points> {
    gegl_curve_num_points($!gc);
  }

  method set_point (Int() $index, Num() $x, Num() $y) is also<set-point> {
    my guint   $i         = $index;
    my gdouble ($xx, $yy) = ($x, $y);

    gegl_curve_set_point($!gc, $i, $xx, $yy);
  }

}
