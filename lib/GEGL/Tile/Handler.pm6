use v6.c;

use Method::Also;

use GEGL::Raw::Types;
use GEGL::Raw::Tile::Handler;

use GEGL::Tile::Source;

our subset GeglTileHandlerAncestry is export of Mu
  where GeglTileHandler | GeglTileSourceAncestry;

class GEGL::Tile::Handler is GEGL::Tile::Source {
  has GeglTileHandler $!gth;

  submethod BUILD ( :$gegl-tile-handler ) {
    self.setGeglTileHandler($gegl-tile-handler) if $gegl-tile-handler;
  }

  method setGeglTileHandler (GeglTileHandlerAncestry $_) {
    my $to-parent;

    $!gth = do {
      when GeglTileHandler {
        $to-parent = cast(GeglTileSource, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GeglTileHandler, $_);
      }
    }
    self.setGeglTileSource($to-parent);
  }

  method GEGL::Raw::Definitions::GeglTileHandler
    is also<GeglTileHandler>
  { $!gth }

  multi method new (GeglTileHandlerAncestry $gegl-tile-handler, :$ref = True) {
    return Num unless $gegl-tile-handler;

    my $o = self.bless( :$gegl-tile-handler );
    $o.ref if $ref;
    $o;
  }

  method source is rw {
    Proxy.new:
      FETCH => -> $     { self.get_source    },
      STORE => -> $, \v { self.set_source(v) }
  }

  method create_tile (Int() $x, Int() $y, Int() $z, :$raw = False)
    is also<create-tile>
  {
    my gint ($xx, $yy, $zz) = ($x, $y, $z);

    propReturnObject(
      gegl_tile_handler_create_tile($!gth, $xx, $yy, $zz),
      $raw,
      |GEGL::Tile.getTypePair
    );
  }

  method damage_rect (GeglRectangle() $rect) is also<damage-rect> {
    gegl_tile_handler_damage_rect($!gth, $rect);
  }

  method damage_tile (Int() $x, Int() $y, Int() $z, Int() $damage)
    is also<damage-tile>
  {
    my gint    ($xx, $yy, $zz) = ($x, $y, $z);
    my guint64 $d              = $damage;

    gegl_tile_handler_damage_tile($!gth, $xx, $yy, $zz, $d);
  }

  method dup_tile (
    GeglTile() $tile,
    Int()      $x,
    Int()      $y,
    Int()      $z,
               :$raw = False
  )
    is also<dup-tile>
  {
    my gint ($xx, $yy, $zz) = ($x, $y, $z);

    propReturnObject(
      gegl_tile_handler_dup_tile($!gth, $tile, $xx, $yy, $zz),
      $raw,
      |GEGL::Tile.getTypePair
    );
  }

  method get_source_tile (
    Int() $x,
    Int() $y,
    Int() $z,
    Int() $preserve_data,
          :$raw           = False
  )
    is also<get-source-tile>
  {
    my gint     ($xx, $yy, $zz) = ($x, $y, $z);
    my gboolean $p              = $preserve_data.so.Int;

    propReturnObject(
      gegl_tile_handler_get_source_tile($!gth, $xx, $yy, $zz, $preserve_data),
      $raw,
      |GEGL::Tile.getTypePair
    );
  }

  method get_source ( :$raw = False ) is also<get-source> {
    propReturnObject(
      $!gth.source,
      $raw,
      |GEGL::Tile::Source.getTypePair
    )
  }

  method get_tile (
    Int() $x,
    Int() $y,
    Int() $z,
    Int() $preserve_data,
          :$raw           = False
  )
    is also<get-tile>
  {
    my gint     ($xx, $yy, $zz) = ($x, $y, $z);
    my gboolean $p              = $preserve_data.so.Int;

    propReturnObject(
      gegl_tile_handler_get_tile($!gth, $xx, $yy, $zz, $preserve_data),
      $raw,
      |GEGL::Tile.getTypePair
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gegl_tile_handler_get_type, $n, $t );
  }

  method lock {
    gegl_tile_handler_lock($!gth);
  }

  method set_source (GeglTileSource() $source) is also<set-source> {
    gegl_tile_handler_set_source($!gth, $source);
  }

  method unlock {
    gegl_tile_handler_unlock($!gth);
  }

}
