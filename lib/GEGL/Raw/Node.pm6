use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GEGL::Raw::Definitions;
use GEGL::Raw::Enums;
use BABL;

unit package GEGL::Raw::Node;

### /usr/include/gegl/gegl-node.h

sub gegl_node_add_child (GeglNode $graph, GeglNode $child)
  returns GeglNode
  is native(gegl)
  is export
{ * }

sub gegl_node_blit (
  GeglNode      $node,
  gdouble       $scale,
  GeglRectangle $roi,
  Babl          $format,
  gpointer      $destination_buf,
  gint          $rowstride,
  GeglBlitFlags $flags
)
  is native(gegl)
  is export
{ * }

sub gegl_node_blit_buffer (
  GeglNode        $node,
  GeglBuffer      $buffer,
  GeglRectangle   $roi,
  gint            $level,
  GeglAbyssPolicy $abyss_policy
)
  is native(gegl)
  is export
{ * }

sub gegl_node_connect_from (
  GeglNode $sink,
  Str      $input_pad_name,
  GeglNode $source,
  Str      $output_pad_name
)
  returns uint32
  is native(gegl)
  is export
{ * }

sub gegl_node_connect_to (
  GeglNode $source,
  Str      $output_pad_name,
  GeglNode $sink,
  Str      $input_pad_name
)
  returns uint32
  is native(gegl)
  is export
{ * }

sub gegl_node_create_child (GeglNode $parent, Str $operation)
  returns GeglNode
  is native(gegl)
  is export
{ * }

sub gegl_node_detect (GeglNode $node, gint $x, gint $y)
  returns GeglNode
  is native(gegl)
  is export
{ * }

sub gegl_node_disconnect (GeglNode $node, Str $input_pad)
  returns uint32
  is native(gegl)
  is export
{ * }

sub gegl_node_find_property (GeglNode $node, Str $property_name)
  returns GParamSpec
  is native(gegl)
  is export
{ * }

sub gegl_operation_get_op_version (Str $op_name)
  returns Str
  is native(gegl)
  is export
{ * }

sub gegl_node_get (GeglNode $node, Str)
  is native(gegl)
  is export
{ * }

sub gegl_node_get_bounding_box (GeglNode $node)
  returns GeglRectangle
  is native(gegl)
  is export
{ * }

sub gegl_node_get_children (GeglNode $node)
  returns GSList
  is native(gegl)
  is export
{ * }

sub gegl_node_get_consumers (
  GeglNode                 $node,
  Str                      $output_pad,
  CArray[CArray[GeglNode]] $nodes,
  CArray[CArray[Str]]      $pads
)
  returns gint
  is native(gegl)
  is export
{ * }

sub gegl_node_get_gegl_operation (GeglNode $node)
  returns GeglOperation
  is native(gegl)
  is export
{ * }

sub gegl_node_get_input_proxy (GeglNode $node, Str $pad_name)
  returns GeglNode
  is native(gegl)
  is export
{ * }

sub gegl_node_get_operation (GeglNode $node)
  returns Str
  is native(gegl)
  is export
{ * }

sub gegl_node_get_output_proxy (GeglNode $node, Str $pad_name)
  returns GeglNode
  is native(gegl)
  is export
{ * }

sub gegl_node_get_parent (GeglNode $node)
  returns GeglNode
  is native(gegl)
  is export
{ * }

sub gegl_node_get_passthrough (GeglNode $node)
  returns uint32
  is native(gegl)
  is export
{ * }

sub gegl_node_get_producer (
  GeglNode    $node,
  Str         $input_pad_name,
  CArray[Str] $output_pad_name
)
  returns GeglNode
  is native(gegl)
  is export
{ * }

sub gegl_node_get_property (GeglNode $node, Str $property_name, GValue $value)
  is native(gegl)
  is export
{ * }

# sub gegl_node_get_valist (GeglNode $node, Str $first_property_name, va_list $args)
#   is native(gegl)
#   is export
# { * }

sub gegl_node_has_pad (GeglNode $node, Str $pad_name)
  returns uint32
  is native(gegl)
  is export
{ * }

sub gegl_node_is_graph (GeglNode $node)
  returns uint32
  is native(gegl)
  is export
{ * }

sub gegl_node_link (GeglNode $source, GeglNode $sink)
  is native(gegl)
  is export
{ * }

sub gegl_node_link_many (GeglNode $source, GeglNode)
  is native(gegl)
  is export
{ * }

sub gegl_node_list_input_pads (GeglNode $node)
  returns CArray[Str]
  is native(gegl)
  is export
{ * }

sub gegl_node_list_output_pads (GeglNode $node)
  returns CArray[Str]
  is native(gegl)
  is export
{ * }

sub gegl_node_new ()
  returns GeglNode
  is native(gegl)
  is export
{ * }

sub gegl_node_new_child (GeglNode $parent, Str)
  returns GeglNode
  is native(gegl)
  is export
{ * }

sub gegl_node_new_from_file (Str $path)
  returns GeglNode
  is native(gegl)
  is export
{ * }

sub gegl_node_new_from_xml (Str $xmldata, Str $path_root)
  returns GeglNode
  is native(gegl)
  is export
{ * }

sub gegl_node_process (GeglNode $sink_node)
  is native(gegl)
  is export
{ * }

sub gegl_node_progress (GeglNode $node, gdouble $progress, Str $message)
  is native(gegl)
  is export
{ * }

sub gegl_node_remove_child (GeglNode $graph, GeglNode $child)
  returns GeglNode
  is native(gegl)
  is export
{ * }

sub gegl_node_set (GeglNode $node, Str)
  is native(gegl)
  is export
{ * }

sub gegl_node_set_passthrough (GeglNode $node, gboolean $passthrough)
  is native(gegl)
  is export
{ * }

sub gegl_node_set_property (GeglNode $node, Str $property_name, GValue $value)
  is native(gegl)
  is export
{ * }

# sub gegl_node_set_valist (GeglNode $node, Str $first_property_name, va_list $args)
#   is native(gegl)
#   is export
# { * }

sub gegl_node_to_xml (GeglNode $node, Str $path_root)
  returns Str
  is native(gegl)
  is export
{ * }

sub gegl_node_to_xml_full (GeglNode $head, GeglNode $tail, Str $path_root)
  returns Str
  is native(gegl)
  is export
{ * }

### /usr/include/gegl-0.4/gegl-processor.h

sub gegl_node_new_processor (GeglNode $node, GeglRectangle $rectangle)
  returns GeglProcessor
  is native(gegl)
  is export
{ * }
