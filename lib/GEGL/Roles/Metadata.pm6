use v6.c;

use GEGL::Raw::Types;
use GEGL::Raw::Metadata;

use GLib::Roles::Object;

role GEGL::Roles::Metadata {
  has GeglMetadata $!gm;

  method roleInit-GeglMetadata {
    my \i = findProperImplementor(self.^attributes);

    $!gm = cast( GeglMetadata, i.get_value(self) )
  }

  method GEGL::Raw::Definitions::GeglMetadata
  { * }

  proto method get_resolution (|)
  { * }

  multi method get_resolution (Int() $unit) {
    samewith($unit, $, $);
  }

  multi method get_resolution (
    Int() $unit,
          $x      is rw,
          $y      is rw
  ) {
    my GeglResolutionUnit $u         = $unit;
    my gfloat             ($xx, $yy) = 0e0 xx 2;

    gegl_metadata_get_resolution($!gm, $u, $xx, $yy);
    ($x, $y) = ($xx, $yy);
  }

  proto method register_map (|)
  { * }

  multi method register_map (Str() $file_module, Int() $flags, @map) {
    samewith(
      $file_module,
      $flags,
      GLib::Roles::TypedBuffer[GeglMetadataMap].new(@map).p,
      @map.elems
    );
  }
  multi method register_map (
    Str()        $file_module,
    Int()        $flags,
    gpointer     $map,
    Int()        $n_map
  ) {
    my guint $f = $flags;
    my gsize $n = $n_map;

    gegl_metadata_register_map($!gm, $file_module, $map, $n_map);
  }

  proto method set_resolution (|)
  { * }

  multi method set_resolution (Int() $unit, Num() @a where @a.elems == 2) {
    samewith($unit, |@a);
  }
  multi method set_resolution (Int() $unit, Num() $x, Num() $y) {
    my GeglResolutionUnit $u = $unit;

    gegl_metadata_set_resolution($!gm, $u, $x, $y);
  }

  method unregister_map {
    gegl_metadata_unregister_map($!gm);
  }

}

class GEGL::Metadata::Iter {
  has GeglMetadata     $!gm  is built;
  has GeglMetadataIter $!gmi is built;

  submethod BUILD (
    :gegl-metadata(:$!gm),
    :gegl-metadata-iter(:$!gmi)
  ) { }

  multi method new (
    GeglMetadata()     $gegl-metadata,
    GeglMetadataIter() $gegl-metadata-iter
  ) {
    $gegl-metadata && $gegl-metadata-iter
      ?? self.bless(:$gegl-metadata, :$gegl-metadata-iter)
      !! Nil;
  }
  multi method new (GeglMetadata() $gegl-metadata) {
    my $gegl-metadata-iter = GeglMetadataIter.new;

    gegl_metadata_iter_init($gegl-metadata, $gegl-metadata-iter);

    samewith($gegl-metadata, $gegl-metadata-iter);
  }

  method get_value (GValue() $value) {
    gegl_metadata_iter_get_value($!gm, $!gmi, $value);
  }

  method lookup (Str() $key) {
    gegl_metadata_iter_lookup($!gm, $!gmi, $key);
  }

  method next {
    gegl_metadata_iter_next($!gm, $!gmi);
  }

  method set_value (GValue() $value) {
    gegl_metadata_iter_set_value($!gm, $!gmi, $value);
  }
}

our subset GeglMetadataAncestry is export of Mu
  where GeglMetadata | GObject;

class GEGL::Metadata {
  also does GLib::Roles::Object;
  also does GEGL::Roles::Metadata;

  submethod BUILD ( :$gegl-metadata ) {
    self.setGeglMetadata($gegl-metadata) if $gegl-metadata;
  }

  method setGeglMetadata (GeglMetadataAncestry $_) {
    my $to-parent;

    $!gm = do {
      when GeglMetadata {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GeglMetadata, $_);
      }
    }
    self!setObject($to-parent);
  }

  multi method new (GeglMetadataAncestry $gegl-metadata, :$ref = True) {
    return Num unless $gegl-metadata;

    my $o = self.bless( :$gegl-metadata );
    $o.ref if $ref;
    $o;
  }

}
