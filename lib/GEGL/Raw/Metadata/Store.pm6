use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Enums;
use GLib::Raw::Structs;
use GEGL::Raw::Definitions;
use GEGL::Raw::Enums;

unit package GEL::Raw::Metadata::Store;

### /usr/include/gegl-0.4/gegl-metadatastore.h

sub gegl_metadata_store_declare (GeglMetadataStore $self, GParamSpec $pspec)
  is native(gegl)
  is export
{ * }

sub gegl_resolution_unit_get_type ()
  returns GType
  is native(gegl)
  is export
{ * }

sub gegl_metadata_store_get_artist (GeglMetadataStore $self)
  returns Str
  is native(gegl)
  is export
{ * }

sub gegl_metadata_store_get_comment (GeglMetadataStore $self)
  returns Str
  is native(gegl)
  is export
{ * }

sub gegl_metadata_store_get_copyright (GeglMetadataStore $self)
  returns Str
  is native(gegl)
  is export
{ * }

sub gegl_metadata_store_get_description (GeglMetadataStore $self)
  returns Str
  is native(gegl)
  is export
{ * }

sub gegl_metadata_store_get_disclaimer (GeglMetadataStore $self)
  returns Str
  is native(gegl)
  is export
{ * }

sub gegl_metadata_store_get_file_module_name (GeglMetadataStore $self)
  returns Str
  is native(gegl)
  is export
{ * }

sub gegl_metadata_store_get_resolution_unit (GeglMetadataStore $self)
  returns GeglResolutionUnit
  is native(gegl)
  is export
{ * }

sub gegl_metadata_store_get_resolution_x (GeglMetadataStore $self)
  returns gdouble
  is native(gegl)
  is export
{ * }

sub gegl_metadata_store_get_resolution_y (GeglMetadataStore $self)
  returns gdouble
  is native(gegl)
  is export
{ * }

sub gegl_metadata_store_get_software (GeglMetadataStore $self)
  returns Str
  is native(gegl)
  is export
{ * }

sub gegl_metadata_store_get_source (GeglMetadataStore $self)
  returns Str
  is native(gegl)
  is export
{ * }

sub gegl_metadata_store_get_string (GeglMetadataStore $self, Str $name)
  returns Str
  is native(gegl)
  is export
{ * }

sub gegl_metadata_store_get_timestamp (GeglMetadataStore $self)
  returns GDateTime
  is native(gegl)
  is export
{ * }

sub gegl_metadata_store_get_title (GeglMetadataStore $self)
  returns Str
  is native(gegl)
  is export
{ * }

sub gegl_metadata_store_get_value (
  GeglMetadataStore $self,
  Str               $name,
  GValue            $value
)
  is native(gegl)
  is export
{ * }

sub gegl_metadata_store_get_warning (GeglMetadataStore $self)
  returns Str
  is native(gegl)
  is export
{ * }

sub gegl_metadata_store_has_value (GeglMetadataStore $self, Str $name)
  returns uint32
  is native(gegl)
  is export
{ * }

sub gegl_metadata_store_notify (
  GeglMetadataStore $self,
  GParamSpec        $pspec,
  gboolean          $shadow
)
  is native(gegl)
  is export
{ * }

sub gegl_metadata_store_register (
  GeglMetadataStore $self,
  Str               $local_name,
  Str               $name,
                    &transform (GValue, GValue)
)
  is native(gegl)
  is export
{ * }

sub gegl_metadata_store_set_artist (GeglMetadataStore $self, Str $artist)
  is native(gegl)
  is export
{ * }

sub gegl_metadata_store_set_comment (GeglMetadataStore $self, Str $comment)
  is native(gegl)
  is export
{ * }

sub gegl_metadata_store_set_copyright (
  GeglMetadataStore $self,
  Str               $copyright
)
  is native(gegl)
  is export
{ * }

sub gegl_metadata_store_set_description (
  GeglMetadataStore $self,
  Str               $description
)
  is native(gegl)
  is export
{ * }

sub gegl_metadata_store_set_disclaimer (
  GeglMetadataStore $self,
  Str               $disclaimer
)
  is native(gegl)
  is export
{ * }

sub gegl_metadata_store_set_resolution_unit (
  GeglMetadataStore  $self,
  GeglResolutionUnit $unit
)
  is native(gegl)
  is export
{ * }

sub gegl_metadata_store_set_resolution_x (
  GeglMetadataStore $self,
  gdouble           $resolution_x
)
  is native(gegl)
  is export
{ * }

sub gegl_metadata_store_set_resolution_y (
  GeglMetadataStore $self,
  gdouble           $resolution_y
)
  is native(gegl)
  is export
{ * }

sub gegl_metadata_store_set_software (GeglMetadataStore $self, Str $software)
  is native(gegl)
  is export
{ * }

sub gegl_metadata_store_set_source (GeglMetadataStore $self, Str $source)
  is native(gegl)
  is export
{ * }

sub gegl_metadata_store_set_string (
  GeglMetadataStore $self,
  Str               $name,
  Str               $string
)
  is native(gegl)
  is export
{ * }

sub gegl_metadata_store_set_timestamp (
  GeglMetadataStore $self,
  GDateTime         $timestamp
)
  is native(gegl)
  is export
{ * }

sub gegl_metadata_store_set_title (GeglMetadataStore $self, Str $title)
  is native(gegl)
  is export
{ * }

sub gegl_metadata_store_set_value (
  GeglMetadataStore $self,
  Str               $name,
  GValue            $value
)
  is native(gegl)
  is export
{ * }

sub gegl_metadata_store_set_warning (GeglMetadataStore $self, Str $warning)
  is native(gegl)
  is export
{ * }

sub gegl_metadata_store_typeof_value (GeglMetadataStore $self, Str $name)
  returns GType
  is native(gegl)
  is export
{ * }
