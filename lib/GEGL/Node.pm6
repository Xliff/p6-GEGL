use v6.c;

use Method::Also;

use NativeCall;

use GEGL::Raw::Types;
use GEGL::Raw::Node;
use GEGL::Raw::OperationParams;

use GLib::GList;
use GLib::Object::ParamSpec;

use GLib::Roles::Object;
use GEGL::Roles::Signals::Generic;

use GLib::Value;

our subset GeglNodeAncestry is export of Mu
  where GeglNode | GeglVisitable | GObject;

sub resolveOperationParam ($op is copy, $name, $value is copy) {
  return Nil unless $value;

  return gv_str($value) if $name eq 'operation';

  $op .= subst('gegl:', '');
  say "Resoving for { $op } / { $name } -> {
       %operations{$op}{$name} // '»NIL«' }";

  say "O: { %operations.gist } / { %operations.WHERE }";

  given %operations{$op}{$name} {
    when Pair {
      say "GEGL::Node.set -- Pair using type { .value } for attribute { .key }";

      my $pair = $_;
      my $v;
      given .key {
        when 'object' {
          say "PV: { $pair.value }";
          $v = GLib::Value.new( $pair.value );
        }

        when 'pointer' {
          $v = GLib::Value.new(G_TYPE_POINTER);
          $value = $value."{ $pair.value }"();
        }
      }

      $v."{ .key }"() = $value;
      $v;
    }

    when 'float' {
      gv_flt($value);
    }

    when 'double' {
      gv_dbl($value);
    }

    when 'string' {
      gv_str($value);
    }

    when 'pointer' {
      gv_ptr($value);
    }

    when .starts-with('int') | .starts-with('uint') {
      say "Using '{ $_ }' for { $op }.{ $name }";

      $_ ?? ::("\&gv_{ $_ }")($value) !! Nil;
    }

    default {
      X::GEGL::Node::NoOperationResolution.new( $op, $name, .^name ).throw;
    }
  }
}

class GEGL::Node {
  also does GLib::Roles::Object;
  also does GEGL::Roles::Signals::Generic;

  has GeglNode $!gn         is implementor;

  submethod BUILD ( :$gegl-node ) {
    self.setGeglNode($gegl-node) if $gegl-node;
  }

  method setGeglNode (GeglNodeAncestry $_) {
    my $to-parent;

    $!gn = do {
      when GeglNode {
        $to-parent = cast(GObject, $_);
        $_;
      }

      when GeglVisitable {
        $to-parent = cast(GObject, $_);
        # $!gv = $_;
        cast(GeglNode, $_);
      }

      default {
        $to-parent = $_;
        cast(GeglNode, $_);
      }
    }
    self!setObject($to-parent);
    #self.roleInit-GeglVisibtable;
  }

  method GEGL::Raw::Definitions::GeglNode
    is also<GeglNode>
  { $!gn }

  multi method new (GeglNodeAncestry $gegl-node, :$ref = True) {
    return Nil unless $gegl-node;

    my $o = self.bless(:$gegl-node);
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $gegl-node = gegl_node_new();

    $gegl-node ?? self.bless( :$gegl-node ) !! Nil;
  }

  method new_from_file (Str() $path) is also<new-from-file> {
    my $gegl-node = gegl_node_new_from_file($path);

    $gegl-node ?? self.bless( :$gegl-node ) !! Nil;
  }

  method new_from_xml (Str() $xmldata, Str() $path_root)
    is also<new-from-xml>
  {
    my $gegl-node = gegl_node_new_from_xml($xmldata, $path_root);

    $gegl-node ?? self.bless( :$gegl-node ) !! Nil;
  }

  proto method new_child (|)
    is also<new-child>
  { * }

  multi method new_child (
    *@properties,
    *%named-properties
  ) {
    ::?CLASS.new_child($!gn, |@properties, |%named-properties);
  }
  multi method new_child (
    GEGL::Node:D:

    *@properties,
    :$raw             = False,
    *%named-properties
  ) {
    my $gegl-node = gegl_node_new_child($!gn, Str);

    return Nil unless $gegl-node;

    my $o = self.bless( :$gegl-node );
    $o.set(
      |@properties,
      |%named-properties.pairs.map({ (.key, .value) })
    );

    $o;
  }


  # GeglNode, GeglRectangle, gpointer
  method computed {
    self.connect-rectangle($!gn, 'computed');
  }

  # GeglNode, GeglRectangle, gpointer
  method invalidated {
    self.connect-rectangle($!gn, 'invalidated');
  }

  # GeglNode, float, gpointer
  method progress {
    self.connect-float($!gn, 'progress');
  }

  method add_child (GeglNode() $child, :$raw = False) is also<add-child> {
    propReturnObject(
      gegl_node_add_child($!gn, $child),
      $raw,
      |self.getTypePair
    );
  }

  method blit (
    Num()           $scale,
    GeglRectangle() $roi,
    Babl()          $format,
    gpointer        $destination_buf,
    Int()           $rowstride,
    Int()           $flags
  ) {
    my gdouble       $s = $scale;
    my gint          $r = $rowstride;
    my GeglBlitFlags $f = $flags;

    gegl_node_blit(
      $!gn,
      $s,
      $roi,
      $format,
      $destination_buf,
      $r,
      $f
    );
  }

  method blit_buffer (
    GeglBuffer()     $buffer,
    GeglRectangle()  $roi,
    Int()            $level,
    Int()            $abyss_policy
  )
    is also<blit-buffer>
  {
    my gint            $l = $level;
    my GeglAbyssPolicy $a = $abyss_policy;

    gegl_node_blit_buffer($!gn, $buffer, $roi, $l, $a);
  }

  method connect_from (
    Str()      $input_pad_name,
    GeglNode() $source,
    Str()      $output_pad_name
  )
    is also<connect-from>
  {
    so gegl_node_connect_from($!gn, $input_pad_name, $source, $output_pad_name);
  }

  method connect_to (
    Str()      $output_pad_name,
    GeglNode() $sink,
    Str()      $input_pad_name
  )
    is also<connect-to>
  {
    so gegl_node_connect_to($!gn, $output_pad_name, $sink, $input_pad_name);
  }

  method create_child (Str() $operation, :$raw = False) is also<create-child> {
    propReturnObject(
      gegl_node_create_child($!gn, $operation),
      $raw,
      |self.getTypePair
    )
  }

  method detect (Int() $x, Int() $y, :$raw = False) {
    my gint ($xx, $yy) = ($x, $y);

    propReturnObject(
      gegl_node_detect($!gn, $xx, $yy),
      $raw,
      |self.getTypePair
    );
  }

  method disconnect (Str() $input_pad) {
    so gegl_node_disconnect($!gn, $input_pad);
  }

  method find_property (Str() $property_name, :$raw = False)
    is also<find-property>
  {
    propReturnObject(
      gegl_node_find_property($!gn, $property_name),
      $raw,
      GLib::Object::ParamSpec
    );
  }

  # method gegl_operation_get_op_version {
  #   gegl_operation_get_op_version($!gn);
  # }

  multi method get (
    *@property-names,
    :$hash  is required,
    :$RAW   =  False,
    :$VALUE =  False
  ) {
    my %h;
    my @v = @property-names.map({
      Pair.new(
        $_,
        self.get_property($_, raw => $RAW, value => $VALUE)
      );
    });
    @v.map( .value ) unless $hash;
    @v.Hash;
  }

  method get_bounding_box is also<get-bounding-box> {
    gegl_node_get_bounding_box($!gn);
  }

  method get_children ( :$raw = False, :$glist = False )
    is also<get-children>
  {
    returnGList(
      gegl_node_get_children($!gn),
      $raw,
      $glist,
      |self.getTypePair
    )
  }

  proto method get_consumers (|)
    is also<get-consumers>
  { * }

  multi method get_consumers (Str() $output_pad, :$raw = False) {
    (my $n = CArray[CArray[GeglNode]].new)[0] = CArray[GeglNode];
    (my $p = CArray[CArray[Str]].new)[0]      = CArray[Str];
    samewith($output_pad, $, $, :$raw);
  }
  multi method get_consumers (
    Str()                    $output_pad,
    CArray[CArray[GeglNode]] $nodes,
    CArray[CArray[Str]]      $pads,
                            :$raw    = False
  ) {
    my $num = gegl_node_get_consumers($!gn, $output_pad, $nodes, $pads);
    my @nodes = CArrayToArray( ppr($nodes) );
    my @pads  = CStringArrayToArray( ppr($pads) );
    @nodes .= map({ GEGL::Node.new($_) }) unless $raw;

    (@nodes, @pads)
  }

  method get_gegl_operation is also<get-gegl-operation> {
    gegl_node_get_gegl_operation($!gn);
  }

  method get_input_proxy (Str() $pad_name, :$raw = False)
    is also<get-input-proxy>
  {
    propReturnObject(
      gegl_node_get_input_proxy($!gn, $pad_name),
      $raw,
      |self.getTypePair
    );
  }

  method get_operation is also<get-operation> {
    gegl_node_get_operation($!gn);
  }

  method get_output_proxy (Str() $pad_name, :$raw = False)
    is also<get-output-proxy>
  {
    propReturnObject(
      gegl_node_get_output_proxy($!gn, $pad_name),
      $raw,
      |self.getTypePair
    );
  }

  method get_parent ( :$raw = False ) is also<get-parent> {
    propReturnObject(
      gegl_node_get_parent($!gn),
      $raw,
      |self.getTypePair
    );
  }

  method get_passthrough is also<get-passthrough> {
    so gegl_node_get_passthrough($!gn);
  }

  proto method get_producer (|)
    is also<get-producer>
  { * }

  multi method get_producer (
    Str() $input_pad_name,
          :$all            = False,
          :$raw            = False
  ) {
    (my $opn = CArray[Str].new)[0] = Str;
    my @r = samewith($input_pad_name, $opn, :$raw);
    $all ?? @r !! @r[0];
  }
  multi method get_producer (
    Str()       $input_pad_name,
    CArray[Str] $output_pad_name = CArray[Str],
                :$raw            = False
  ) {
    my $p = propReturnObject(
      gegl_node_get_producer($!gn, $input_pad_name, $output_pad_name),
      $raw,
      |self.getTypePair
    );
    ( $p, ppr($output_pad_name) )
  }

  proto method get_property (|)
    is also<get-property>
  { * }

  multi method get_property (
    Str() $property_name,
          :$raw           = False,
          :$value         = False
  ) {
    my $v = GValue.new;

    samewith($property_name, $v, :$raw, $value);
  }
  multi method get_property (
    Str() $property_name,
    GValue() $gval,
    :$raw                 = False,
    :$value               = False
  ) {
    gegl_node_get_property($!gn, $property_name, $gval);
    return $value if $raw;
    my $v = GLib::Value.new($gval);
    return $v.value if $value;
    $v;
  }

  method has_pad (Str() $pad_name) is also<has-pad> {
    so gegl_node_has_pad($!gn, $pad_name);
  }

  method is_graph is also<is-graph> {
    so gegl_node_is_graph($!gn);
  }

  method link (GeglNode() $sink) {
    gegl_node_link($!gn, $sink);
  }

  method link_many ( *@sinks ) is also<link-many> {
    @sinks.unshift($!gn);
    for @sinks.rotor( 2 => -1 ) -> ($source, $sink) {
      gegl_node_link($source, $sink)
    }
  }

  method list_input_pads is also<list-input-pads> {
    CStringArrayToArray( gegl_node_list_input_pads($!gn) );
  }

  method list_output_pads is also<list-output-pads> {
    CStringArrayToArray( gegl_node_list_output_pads($!gn) );
  }

  method new_processor (GeglRectangle() $rectangle, :$raw = False) {
    propReturnObject(
      gegl_node_new_processor($!gn, $rectangle),
      $raw,
      |::('GEGL::Processor').getTypePair
    )
  }

  method process {
    gegl_node_process($!gn);
  }

  method emit_progress (Num() $progress, Str() $message)
    is also<emit-progress>
  {
    my gdouble $p =  $progress;

    gegl_node_progress($!gn, $p, $message);
  }

  method remove_child (GeglNode() $child, :$raw = False)
    is also<remove-child>
  {
    propReturnObject(
      gegl_node_remove_child($!gn, $child),
      $raw,
      |self.getTypePair
    );
  }

  multi method set ( *@set-pair, *%set-hash ) {
    %set-hash.append: @set-pair.Hash;

    # Look for operation FIRST if it does not exist.
    unless self.get_operation {
      if %set-hash<operation>:exists {
        say 'setting operation!';
        self.set_property('operation', %set-hash<operation>);
        %set-hash<operation>:delete;
      }
    }

    my @sets = |%set-hash.pairs.map({ (.key, .value) }).flat;
    say "S: { @sets.gist }";
    for @sets.rotor(2) -> ($n, $v) {
      say "N: { $n } / V: { $v }";
      self.set_property($n, $v);
    }
  }

  method set_passthrough (Int() $passthrough) is also<set-passthrough> {
    my gboolean $p = $passthrough.so.Int;

    gegl_node_set_passthrough($!gn, $p);
  }

  method set_property (Str() $property_name, $value) is also<set-property> {
    say "SetProp: { $property_name }";

    my $v = do given $value {
      when GLib::Value { .GValue }
      when GValue      { $_      }

      default {
        my $op = self.get_operation;

        die "Potential problem discovered as op == 'nop'!"
          if ($op // '') eq 'gegl:nop';

        if $property_name ne 'operation' {
          die 'Must set operation to set by non-GValue!'
            unless $op;
        }
        my $vv = resolveOperationParam($op, $property_name, $_);
        die 'Could not resolve to a GValue'
          unless $vv ~~ (GLib::Value, GValue).any;
        $vv.GValue;
      }
    }
    gegl_node_set_property($!gn, $property_name, $v);
  }

  method to_xml (Str() $path_root) is also<to-xml> {
    gegl_node_to_xml($!gn, $path_root);
  }

  method to_xml_full (GeglNode() $tail, Str() $path_root)
    is also<to-xml-full>
  {
    gegl_node_to_xml_full($!gn, $tail, $path_root);
  }

}
