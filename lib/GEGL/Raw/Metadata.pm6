use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GEGL::Raw::Definitions;
use GEGL::Raw::Enums;
use GEGL::Raw::Structs;

unit package GEGL::Raw::Metadata;

### /usr/include/gegl-0.4/gegl-metadata.h

sub gegl_metadata_register_map (
  GeglMetadata $metadata,
  Str          $file-module,
  guint        $flags,
  Pointer      $map,
  gsize        $n_map
)
  is native(gegl)
  is export
{ * }

sub gegl_metadata_get_resolution (
  GeglMetadata       $metadata,
  GeglResolutionUnit $unit,
  gfloat             $x is rw,
  gfloat             $y is rw
)
  returns uint32
  is native(gegl)
  is export
{ * }

sub gegl_metadata_iter_get_value (
  GeglMetadata     $metadata,
  GeglMetadataIter $iter,
  GValue           $value
)
  returns uint32
  is native(gegl)
  is export
{ * }

sub gegl_metadata_iter_init (GeglMetadata $metadata, GeglMetadataIter $iter)
  is native(gegl)
  is export
{ * }

sub gegl_metadata_iter_lookup (
  GeglMetadata     $metadata,
  GeglMetadataIter $iter,
  Str              $key
)
  returns uint32
  is native(gegl)
  is export
{ * }

sub gegl_metadata_iter_next (GeglMetadata $metadata, GeglMetadataIter $iter)
  returns Str
  is native(gegl)
  is export
{ * }

sub gegl_metadata_iter_set_value (
  GeglMetadata     $metadata,
  GeglMetadataIter $iter,
  GValue           $value
)
  returns uint32
  is native(gegl)
  is export
{ * }

sub gegl_metadata_set_resolution (
  GeglMetadata       $metadata,
  GeglResolutionUnit $unit,
  gfloat             $x,
  gfloat             $y
)
  returns uint32
  is native(gegl)
  is export
{ * }

sub gegl_metadata_unregister_map (GeglMetadata $metadata)
  is native(gegl)
  is export
{ * }

sub gegl_metadata_get_type ()
  returns GType
  is native(gegl)
  is export
{ * }
