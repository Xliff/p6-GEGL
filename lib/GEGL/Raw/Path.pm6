use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Enums;
use GLib::Raw::Structs;
use GEGL::Raw::Definitions;
use GEGL::Raw::Structs;

unit package GEGL::Raw::Path;

### /usr/include/gegl-0.4/gegl-path.h

sub gegl_path_add_flattener (
  &func (GeglPathList --> GeglPathList)
)
  is native(gegl)
  is export
{ * }

sub gegl_path_add_type (Str $type, gint $items, Str $description)
  is native(gegl)
  is export
{ * }

# Several multis based on command.
multi sub gegl_path_append_2 (GeglPath $path, Str, gdouble, gdouble, Str)
  is native(gegl)
  is symbol<gegl_path_append>
  is export
{ * }
multi sub gegl_path_append_6 (
  GeglPath $path,
  Str,
  gdouble,
  gdouble,
  gdouble,
  gdouble,
  gdouble,
  gdouble,
  Str
)
  is native(gegl)
  is symbol<gegl_path_append>
  is export
{ * }
multi sub gegl_path_append_0 (GeglPath $path, Str, Str)
  is native(gegl)
  is symbol<gegl_path_append>
  is export
{ * }

sub gegl_path_calc (
  GeglPath $path,
  gdouble  $pos,
  gdouble  $x     is rw,
  gdouble  $y     is rw
)
  returns uint32
  is native(gegl)
  is export
{ * }

sub gegl_path_calc_values (
  GeglPath        $path,
  guint           $num_samples,
  CArray[gdouble] $xs,
  CArray[gdouble] $ys
)
  is native(gegl)
  is export
{ * }

sub gegl_path_calc_y_for_x (GeglPath $path, gdouble $x, gdouble $y is rw)
  returns gint
  is native(gegl)
  is export
{ * }

sub gegl_path_clear (GeglPath $path)
  is native(gegl)
  is export
{ * }

sub gegl_path_closest_point (
  GeglPath $path,
  gdouble $x,
  gdouble $y,
  gdouble $on_path_x       is rw,
  gdouble $on_path_y       is rw,
  gint    $node_pos_before is rw
)
  returns gdouble
  is native(gegl)
  is export
{ * }

sub gegl_path_dirty (GeglPath $path)
  is native(gegl)
  is export
{ * }

sub gegl_path_foreach (
  GeglPath $path,
           &each_item (GeglPathItem, gpointer),
  gpointer $user_data
)
  is native(gegl)
  is export
{ * }

sub gegl_path_foreach_flat (
  GeglPath $path,
           &each_item (GeglPathItem, gpointer),
  gpointer $user_data
)
  is native(gegl)
  is export
{ * }

sub gegl_path_freeze (GeglPath $path)
  is native(gegl)
  is export
{ * }

sub gegl_path_get_bounds (
  GeglPath $self,
  gdouble  $min_x is rw,
  gdouble  $max_x is rw,
  gdouble  $min_y is rw,
  gdouble  $max_y is rw
)
  is native(gegl)
  is export
{ * }

sub gegl_path_get_flat_path (GeglPath $path)
  returns GeglPathList
  is native(gegl)
  is export
{ * }

sub gegl_path_get_length (GeglPath $path)
  returns gdouble
  is native(gegl)
  is export
{ * }

sub gegl_path_get_matrix (GeglPath $path, GeglMatrix3 $matrix)
  is native(gegl)
  is export
{ * }

sub gegl_path_get_n_nodes (GeglPath $path)
  returns gint
  is native(gegl)
  is export
{ * }

sub gegl_path_get_node (GeglPath $path, gint $index, GeglPathItem $node)
  returns uint32
  is native(gegl)
  is export
{ * }

sub gegl_path_get_path (GeglPath $path)
  returns GeglPathList
  is native(gegl)
  is export
{ * }

sub gegl_path_get_type ()
  returns GType
  is native(gegl)
  is export
{ * }

sub gegl_path_insert_node (GeglPath $path, gint $pos, GeglPathItem $node)
  is native(gegl)
  is export
{ * }

sub gegl_path_is_empty (GeglPath $path)
  returns uint32
  is native(gegl)
  is export
{ * }

sub gegl_path_list_append (GeglPathList $head, GeglPathItem, Str)
  returns GeglPathList
  is native(gegl)
  is export
{ * }

sub gegl_path_list_destroy (GeglPathList $path)
  returns GeglPathList
  is native(gegl)
  is export
{ * }

sub gegl_path_new ()
  returns GeglPath
  is native(gegl)
  is export
{ * }

sub gegl_path_new_from_string (Str $instructions)
  returns GeglPath
  is native(gegl)
  is export
{ * }

sub gegl_path_parse_string (GeglPath $path, Str $instructions)
  is native(gegl)
  is export
{ * }

sub gegl_path_point_dist (GeglPathPoint $a, GeglPathPoint $b)
  returns gdouble
  is native(gegl)
  is export
{ * }

sub gegl_path_point_lerp (
  GeglPathPoint $dest,
  GeglPathPoint $a,
  GeglPathPoint $b,
  gfloat        $t
)
  is native(gegl)
  is export
{ * }

sub gegl_path_remove_node (GeglPath $path, gint $pos)
  is native(gegl)
  is export
{ * }

sub gegl_path_replace_node (GeglPath $path, gint $pos, GeglPathItem $node)
  is native(gegl)
  is export
{ * }

sub gegl_path_set_matrix (GeglPath $path, GeglMatrix3 $matrix)
  is native(gegl)
  is export
{ * }

sub gegl_path_thaw (GeglPath $path)
  is native(gegl)
  is export
{ * }

sub gegl_path_to_string (GeglPath $path)
  returns Str
  is native(gegl)
  is export
{ * }

sub gegl_param_path_get_type ()
  returns GType
  is native(gegl)
  is export
{ * }

sub gegl_param_spec_path (
  Str         $name,
  Str         $nick,
  Str         $blurb,
  GeglPath    $default_path,
  GParamFlags $flags
)
  returns GParamSpec
  is native(gegl)
  is export
{ * }
