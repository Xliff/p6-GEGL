use v6.c;

use Method::Also;

use NativeCall;

use GEGL::Raw::Types;

use GEGL::Tile;

use GLib::Roles::Object;

our subset GeglTileSourceAncestry is export of Mu
 where GeglTileSource | GObject;

class GEGL::Tile::Source {
  also does GLib::Roles::Object;

  has GeglTileSource $!gts is implementor;

  has &!command;
  has $!command-cached;

  submethod BUILD ( :$gegl-tile-source ) {
    self.setGeglTileSource($gegl-tile-source) if $gegl-tile-source;
  }

  method setGeglTileSource (GeglTileSourceAncestry $_) {
    my $to-parent;

    $!gts = do {
      when GeglTileSource {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GeglTileSource, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GEGL::Raw::Definitions::GeglTileSource
    is also<GeglTileSource>
  { $!gts }

  multi method new (GeglTileSourceAncestry $gegl-tile-source, :$ref = True) {
    return Num unless $gegl-tile-source;

    my $o = self.bless( :$gegl-tile-source );
    $o.ref if $ref;
    $o;
  }

  method !command (
    Int()    $command,
    Int()    $x,
    Int()    $y,
    Int()    $z,
    gpointer $user_data = gpointer
  ) {
    my GeglTileCommand $c              = $command;
    my gint            ($xx, $yy, $zz) = ($x, $y, $z);

    without $!command-cached {
      $!command-cached = +$!gts.command.p
    }
    unless $!command-cached == +$!gts.command.p {
      &!command = Nil;
    }
    without &!command {
      &!command = cast(
        :(GeglTileCommand, gint, gint, gint, gpointer --> GeglTile),
        $!gts.command
      );
    }

    &!command($c, $xx, $yy, $zz, gpointer);
  }

  method copy (
    Int()        $x,
    Int()        $y,
    Int()        $z,
    GeglTileSource() $dst_buffer,
    Int()        $dst_x,
    Int()        $dst_y,
    Int()        $dst_z
  ) {
    my $p = GeglTileCopyParams.new.set($dst_x, $dst_y, $dst_z, $dst_buffer);

    self!command(GEGL_TILE_COPY, $x, $y, $z, $p.p).so
  }

  method get_tile (Int() $x, Int() $y, Int() $z, :$raw = False)
    is also<get-tile>
  {
    propReturnObject(
      self!command(GEGL_TILE_GET, $x, $y, $z),
      $raw,
      |GEGL::Tile.getTypeaPair
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gegl_tile_source_get_type, $n, $t );
  }

  method set_tile (Int() $x, Int() $y, Int() $z, GeglTile() $tile)
    is also<set-tile>
  {
    self!command(GEGL_TILE_SET, $x, $y, $z, $tile.p) !=:= GeglTile
  }

  method exist (Int() $x, Int() $y, Int() $z) {
    self!command(GEGL_TILE_EXIST, $x, $y, $z, gpointer) !=:= GeglTile
  }

  method idle (Int() $x, Int() $y, Int() $z) {
    self!command(GEGL_TILE_IDLE, $x, $y, $z, gpointer) !=:= GeglTile
  }

  method is_cached (Int() $x, Int() $y, Int() $z) is also<is-cached> {
    self!command(GEGL_TILE_IS_CACHED, $x, $y, $z, gpointer) !=:= GeglTile
  }

  method refetch (Int() $x, Int() $y, Int() $z) {
    self!command(GEGL_TILE_REFETCH, $x, $y, $z, gpointer);
  }

  method reinit {
    self!command(GEGL_TILE_REINIT, 0, 0, 0, gpointer)
  }

  method void {
    self!command(GEGL_TILE_VOID, 0, 0, 0, gpointer)
  }

}

sub gegl_tile_source_get_type ()
  returns GType
  is native(gegl)
  is export
{ * }
