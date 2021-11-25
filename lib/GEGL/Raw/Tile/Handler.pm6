use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GEGL::Raw::Definitions;
use GEGL::Raw::Structs;

unit package GEGL::Raw::Tile::Handler;

### /usr/include/gegl-0.4/gegl-tile-handler.h

sub gegl_tile_handler_create_tile (
  GeglTileHandler $handler,
  gint            $x,
  gint            $y,
  gint            $z
)
  returns GeglTile
  is native(gegl)
  is export
{ * }

sub gegl_tile_handler_damage_rect (
  GeglTileHandler $handler,
  GeglRectangle   $rect
)
  is native(gegl)
  is export
{ * }

sub gegl_tile_handler_damage_tile (
  GeglTileHandler $handler,
  gint            $x,
  gint            $y,
  gint            $z,
  guint64         $damage
)
  is native(gegl)
  is export
{ * }

sub gegl_tile_handler_dup_tile (
  GeglTileHandler $handler,
  GeglTile        $tile,
  gint            $x,
  gint            $y,
  gint            $z
)
  returns GeglTile
  is native(gegl)
  is export
{ * }

sub gegl_tile_handler_get_source_tile (
  GeglTileHandler $handler,
  gint            $x,
  gint            $y,
  gint            $z,
  gboolean        $preserve_data
)
  returns GeglTile
  is native(gegl)
  is export
{ * }

sub gegl_tile_handler_get_tile (
  GeglTileHandler $handler,
  gint            $x,
  gint            $y,
  gint            $z,
  gboolean        $preserve_data
)
  returns GeglTile
  is native(gegl)
  is export
{ * }

sub gegl_tile_handler_get_type ()
  returns GType
  is native(gegl)
  is export
{ * }

sub gegl_tile_handler_lock (GeglTileHandler $handler)
  is native(gegl)
  is export
{ * }

sub gegl_tile_handler_set_source (
  GeglTileHandler $handler,
  GeglTileSource  $source
)
  is native(gegl)
  is export
{ * }

sub gegl_tile_handler_unlock (GeglTileHandler $handler)
  is native(gegl)
  is export
{ * }
