use v6.c;

use NativeCall;

use Method::Also;

use GEGL::Raw::Types;
use GEGL::Raw::Path;

use GEGL::Matrix;
use GEGL::Rectangle;

use GLib::Roles::Object;
use GEGL::Roles::Signals::Generic;

our subset GeglPathAnecstry is export of Mu
  where GeglPath | GObject;

# 1 signal:
#  - changed (GeglPath, GeglRectangle, pointer) [?]

class GEGL::Path {
  also does GLib::Roles::Object;
  also does GEGL::Roles::Signals::Generic;

  has GeglPath $!gp is implementor;

  method GEGL::Raw::Definitions::GeglPath
    is also<GeglPath>
  { $!gp }

  method new {
    my $gegl-path = gegl_path_new();

    $gegl-path ?? self.bless( :$gegl-path ) !! Nil;
  }

  method new_from_string (Str() $instructions) is also<new-from-string> {
    my $gegl-path = gegl_path_new_from_string($instructions);

    $gegl-path ?? self.bless( :$gegl-path ) !! Nil;
  }

  method changed {
    self.connect-rectangle($!gp, 'changed');
  }

  method parse_string (Str() $instructions) is also<parse-string> {
    gegl_path_parse_string($!gp, $instructions);
  }

  method add_flattener (GEGL::Path:U: &flattener) is also<add-flattener> {
    gegl_path_add_flattener(&flattener);
  }

  method add_type (
    GEGL::Path:U:

    Str() $type,
    Int() $items,
    Str() $description
  )
    is also<add-type>
  {
    my gint $i = $items;

    gegl_path_add_type($type, $items, $description);
  }

  method append (*@cmds) {
    while @cmds {
      given @cmds.head {
        when 'M' | 'm' | 'L' | 'l' {
          my         $cmd   = @cmds.shift;
          my gdouble @point = @cmds.shift xx 2;

          gegl_path_append_2($!gp, $cmd, |@point, Str);
        }

        when 'C' | 'c' {
          my    $cmd = @cmds.shift;
          my gdouble @points = @cmds xx 6;

          gegl_path_append_6($!gp, $cmd, |@points, Str);
        }

        when 's' | 'z' | .not | .ord == 0 {
          my $cmd = @cmds.shift;

          gegl_path_append_0($!gp, $cmd, Str);
        }

        default {
          die 'Invalid GeglPath command!'
        }
      }
    }
  }

  multi method calc (Num() $pos) {
    samewith($pos, $, $);
  }
  multi method calc (Num() $pos, $x is rw, $y is rw) {
    my gdouble ($xx, $yy) = 0e0 xx 2;

    gegl_path_calc($!gp, $pos, $xx, $yy);
    ($x, $y) = ($xx, $yy);
  }


  proto method calc_values (|)
    is also<calc-values>
  { * }

  multi method calc_values (
    Int()           $num_samples
  ) {
    my ($xs, $ys) = CArray[gdouble].allocate($num_samples) xx 2;

    samewith($num_samples, $xs, $ys);
    ($xs, $ys);
  };
  multi method calc_values (
    Int()           $num_samples,
    CArray[gdouble] $xs,
    CArray[gdouble] $ys
  ) {
    my guint $n = $num_samples;

    die q[$xs isn't large enough] unless $xs.elems >= $num_samples;
    die q[$ys isn't large enough] unless $ys.elems >= $num_samples;

    gegl_path_calc_values($!gp, $num_samples, $xs, $ys);
  }


  proto method calc_y_for_x (|)
    is also<calc-y-for-x>
  { * }

  multi method calc_y_for_x (Num() $x)  {
    samewith($x, $);
  }
  multi method calc_y_for_x (Num() $x, $y is rw) {
    my gdouble ($xx, $yy) = ($x, 0e0);

    gegl_path_calc_y_for_x($!gp, $xx, $yy);
    $y = $yy;
  }

  method clear {
    gegl_path_clear($!gp);
  }

  proto method closest_point (|)
    is also<closest-point>
  { * }

  multi method closest_point (Num() $x, Num() $y)  {
    samewith($x, $y, $, $, $);
  }
  multi method closest_point (
    Num() $x,
    Num() $y,
          $on_path_x       is rw,
          $on_path_y       is rw,
          $node_pos_before is rw
  ) {
    my gdouble ($xx, $yy, $opx, $opy) = ($x, $y, 0, 0);
    my gint    $n                     = 0;

    gegl_path_closest_point($!gp, $xx, $yy, $opx, $opy, $n);
    ($on_path_x, $on_path_y, $node_pos_before) = ($opx, $opy, $n);
  }

  method dirty {
    gegl_path_dirty($!gp);
  }

  method foreach (&each_item, gpointer $user_data = gpointer) {
    gegl_path_foreach($!gp, &each_item, $user_data);
  }

  method foreach_flat (&each_item, gpointer $user_data = gpointer)
    is also<foreach-flat>
  {
    gegl_path_foreach_flat($!gp, &each_item, $user_data);
  }

  method freeze {
    gegl_path_freeze($!gp);
  }

  # method gegl_param_path_get_type {
  #   gegl_param_path_get_type();
  # }
  #
  # method gegl_param_spec_path (Str $nick, Str $blurb, GeglPath $default_path, GParamFlags $flags) {
  #   gegl_param_spec_path($!gp, $nick, $blurb, $default_path, $flags);
  # }

  proto method get_bounds (|)
    is also<get-bounds>
  { * }

  multi method get_bounds ( :$rect = True, :$raw = False )  {
    samewith( $, $, $, $, :$rect, :$raw );
  }
  multi method get_bounds (
    $min_x is rw,
    $max_x is rw,
    $min_y is rw,
    $max_y is rw,
    :$rect =  False,
    :$raw  =  False
  ) {
    my gdouble ($mnx, $mxx, $mny, $mxy) = 0e0 xx 4;

    gegl_path_get_bounds($!gp, $mnx, $mxx, $mny, $mxy);
    ($min_x, $max_x, $min_y, $max_y) = ($mnx, $mxx, $mny, $mxy);
    return ($min_x, $max_x, $min_y, $max_y) unless $rect;

    propReturnObject(
      GeglRectangle.new(
        x      => $min_x,
        y      => $min_y,
        width  => $max_x - $min_x,
        height => $max_y - $min_y
      ),
      $raw,
      |GEGL::Rectangle.getTypePair
    );
  }

  method get_flat_path is also<get-flat-path> {
    # GeglPathList - no object yet.
    gegl_path_get_flat_path($!gp);
  }

  method get_length is also<get-length> {
    gegl_path_get_length($!gp);
  }

  proto method get_matrix (|)
    is also<get-matrix>
  { * }

  multi method get_matrix (:$raw = False) {
    my $m = GeglMatrix3.new;
    samewith($m);
    propReturnObject($m, $raw, |GEGL::Matrix.getTypePair);
  }
  multi method get_matrix (GeglMatrix3() $matrix) {
    gegl_path_get_matrix($!gp, $matrix);
  }

  method get_n_nodes is also<get-n-nodes> {
    gegl_path_get_n_nodes($!gp);
  }

  method get_node (Int() $index, GeglPathItem() $node) is also<get-node> {
    my gint $i = $index;

    gegl_path_get_node($!gp, $i, $node);
  }

  method get_path is also<get-path> {
    # GeglPathList - no object yet
    gegl_path_get_path($!gp);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gegl_path_get_type, $n, $t );
  }

  method insert_node (Int() $pos, GeglPathItem() $node) is also<insert-node> {
    my gint $p = $pos;

    gegl_path_insert_node($!gp, $p, $node);
  }

  method is_empty is also<is-empty> {
    so gegl_path_is_empty($!gp);
  }

  method remove_node (Int() $pos) is also<remove-node> {
    my gint $p = $pos;

    gegl_path_remove_node($!gp, $p);
  }

  method replace_node (Int() $pos, GeglPathItem() $node)
    is also<replace-node>
  {
    my gint $p = $pos;

    gegl_path_replace_node($!gp, $p, $node);
  }

  proto method set_matrix (|)
    is also<set-matrix>
  { * }

  multi method set_matrix ( :$raw = False ){
    my $m = GeglMatrix3.new;

    samewith($m);

    propReturnObject($m, $raw, |GEGL::Matrix.getTypePair);
  }
  multi method set_matrix (GeglMatrix3() $matrix) {
    gegl_path_set_matrix($!gp, $matrix);
  }

  method thaw {
    gegl_path_thaw($!gp);
  }

  method to_string is also<to-string> {
    gegl_path_to_string($!gp);
  }

}

# BOXED
class GEGL::Path::List {
  has GeglPathList $!gpl;

  submethod BUILD ( :$gegl-path-list ) {
    $!gpl = $gegl-path-list;
  }

  method GEGL::Raw::Structs::GeglPathList
    is also<GeglPathList>
  { $!gpl }

  method new (GeglPathList $gegl-path-list) {
    $gegl-path-list ?? self.bless( :$gegl-path-list ) !! Nil;
  }

  method append (*@path-items) {
    gegl_path_list_append($!gpl, $_, Str) for @path-items;
  }

  method destroy {
    gegl_path_list_destroy($!gpl);
  }
}

# BOXED
class GEGL::Path::Point {

  has GeglPathPoint $!gpp;

  submethod BUILD ( :$gegl-path-point ) {
    $!gpp = $gegl-path-point;
  }

  method GEGL::Raw::Structs::GeglPathPoint
    is also<GeglPathPoint>
  { $!gpp }

  method new (GeglPathPoint $gegl-path-point) {
    $gegl-path-point ?? self.bless( :$gegl-path-point ) !! Nil;
  }

  method dist (GeglPathPoint() $b) {
    gegl_path_point_dist($!gpp, $b);
  }

  method lerp (GeglPathPoint() $a, GeglPathPoint() $b, Num() $t) {
    my gfloat $tt = $t;

    gegl_path_point_lerp($!gpp, $a, $b, $tt);
  }

}
