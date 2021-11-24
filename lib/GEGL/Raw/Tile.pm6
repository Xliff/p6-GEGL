use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GEGL::Raw::Definitions;

unit package GEGL::Raw::Tile;

### /usr/include/gegl-0.4/gegl-tile.h

sub gegl_tile_dup (GeglTile $tile)
  returns GeglTile
  is native(gegl)
  is export
{ * }

sub gegl_tile_get_data (GeglTile $tile)
  returns CArray[uint8]
  is native(gegl)
  is export
{ * }

sub gegl_tile_get_rev (GeglTile $tile)
  returns guint
  is native(gegl)
  is export
{ * }

sub gegl_tile_is_stored (GeglTile $tile)
  returns uint32
  is native(gegl)
  is export
{ * }

sub gegl_tile_lock (GeglTile $tile)
  is native(gegl)
  is export
{ * }

sub gegl_tile_mark_as_stored (GeglTile $tile)
  is native(gegl)
  is export
{ * }

sub gegl_tile_new (gint $size)
  returns GeglTile
  is native(gegl)
  is export
{ * }

sub gegl_tile_new_bare ()
  returns GeglTile
  is native(gegl)
  is export
{ * }

sub gegl_tile_read_lock (GeglTile $tile)
  is native(gegl)
  is export
{ * }

sub gegl_tile_read_unlock (GeglTile $tile)
  is native(gegl)
  is export
{ * }

sub gegl_tile_ref (GeglTile $tile)
  returns GeglTile
  is native(gegl)
  is export
{ * }

sub gegl_tile_set_data (
  GeglTile $tile,
  gpointer $pixel_data,
  gint     $pixel_data_size
)
  is native(gegl)
  is export
{ * }

sub gegl_tile_set_data_full (
  GeglTile       $tile,
  gpointer       $pixel_data,
  gint           $pixel_data_size,
  GDestroyNotify $destroy_notify,
  gpointer       $destroy_notify_data
)
  is native(gegl)
  is export
{ * }

sub gegl_tile_set_rev (GeglTile $tile, guint $rev)
  is native(gegl)
  is export
{ * }

sub gegl_tile_set_unlock_notify (
  GeglTile $tile,
           &unlock_notify (GeglTile, gpointer),
  gpointer $unlock_notify_data
)
  is native(gegl)
  is export
{ * }

sub gegl_tile_store (GeglTile $tile)
  returns uint32
  is native(gegl)
  is export
{ * }

sub gegl_tile_unlock (GeglTile $tile)
  is native(gegl)
  is export
{ * }

sub gegl_tile_unref (GeglTile $tile)
  is native(gegl)
  is export
{ * }

sub gegl_tile_void (GeglTile $tile)
  is native(gegl)
  is export
{ * }
