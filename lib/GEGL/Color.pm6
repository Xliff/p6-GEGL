use v6.c;

use Method::Also;

use GEGL::Raw::Types;
use GEGL::Raw::Color;

use GLib::Roles::Object;

our subset GeglColorAncestry is export of Mu
  where GeglColor | GObject;

class GEGL::Color {
  also does GLib::Roles::Object;

  has GeglColor $!gc;

  submethod BUILD ( :$gegl-color ) {
    self.setGeglColor($gegl-color) if $gegl-color;
  }

  method setGeglColor (GeglColorAncestry $_) {
    my $to-parent;

    $!gc = do {
      when GeglColor {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GeglColor, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GEGL::Raw::Definitions::GeglColor
    is also<GeglColor>
  { $!gc }

  multi method new (GeglColorAncestry $gegl-color, :$ref = True) {
    return Num unless $gegl-color;

    my $o = self.bless( :$gegl-color );
    $o.ref if $ref;
    $o;
  }
  multi method new ( Str() $string = 'rgb(0,0,0)' ) {
    my $gegl-color = gegl_color_new($string);

    #say "GEGL-Color: { $gegl-color // '»NIL«' }} / ({ +($gegl-color // 0) })";

    $gegl-color ?? self.bless( :$gegl-color ) !! Nil;
  }
  multi method new (Num() $red, Num() $green, Num() $blue, Num() $alpha?) {
    my $c = self.new;
    $c.set_rgba($red, $green, $blue, $alpha // 1);
    $c;
  }

  method duplicate {
    gegl_color_duplicate($!gc);
  }

  method gegl_param_color_get_type is also<gegl-param-color-get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gegl_param_color_get_type, $n, $t );
  }

  method get_format is also<get-format> {
    gegl_color_get_format($!gc);
  }

  method get_pixel (Babl() $format, gpointer $pixel) is also<get-pixel> {
    gegl_color_get_pixel($!gc, $format, $pixel);
  }

  proto method get_rgba (|)
    is also<get-rgba>
  { * }

  multi method get_rgba {
    samewith($, $, $, $);
  }
  multi method get_rgba (
    $red   is rw,
    $green is rw,
    $blue  is rw,
    $alpha is rw
  ) {
    my gdouble ($r, $g, $b, $a) = 0e0 xx 4;

    gegl_color_get_rgba($!gc, $r, $g, $b, $a);
    ($red, $green, $blue, $alpha) = ($r, $g, $b, $a);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gegl_color_get_type, $n, $t );
  }

  method set_pixel (Babl() $format, gpointer $pixel) is also<set-pixel> {
    gegl_color_set_pixel($!gc, $format, $pixel);
  }

  method set_rgba (Num() $red, Num() $green, Num() $blue, Num() $alpha) is also<set-rgba> {
    my gdouble ($r, $g, $b, $a) = ($red, $green, $blue, $alpha);

    gegl_color_set_rgba($!gc, $r, $g, $b, $a);
  }

}

# method gegl_param_spec_color (Str $nick, Str $blurb, GeglColor $default_color, GParamFlags $flags) {
#   gegl_param_spec_color($!gc, $nick, $blurb, $default_color, $flags);
# }
#
# method gegl_param_spec_color_from_string (Str $nick, Str $blurb, Str $default_color_string, GParamFlags $flags) {
#   gegl_param_spec_color_from_string($!gc, $nick, $blurb, $default_color_string, $flags);
# }
#
# method gegl_param_spec_color_get_default {
#   gegl_param_spec_color_get_default($!gc);
# }
