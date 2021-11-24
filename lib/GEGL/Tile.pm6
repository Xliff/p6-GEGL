use v6.c;

use GEGL::Raw::Types;
use GEGL::Raw::Tile;

# BOXED (untyped)

class GEGL::Tile {
  also does GLib::Roles::Implementor;

  has GeglTile $!gt is implementor;

  submethod BUILD ( :$gegl-tile ) {
    $!gt = $gegl-tile;
  }

  method GEGL::Raw::Definitions::GeglTile
  { $!gt }

  method new (Int() $size) {
    my gint $s         = $size;
    my      $gegl-tile = gegl_tile_new($s);

    $gegl-tile ?? self.bless( :$gegl-tile ) !! Nil;
  }

  method new_bare {
    my $gegl-tile = gegl_tile_new_bare();

    $gegl-tile ?? self.bless( :$gegl-tile ) !! Nil;
  }

  method dup ( :$raw = False ) {
    propReturnObject(
      gegl_tile_dup($!gt),
      $raw,
      |self.getTypePair
    );
  }

  method get_data {
    gegl_tile_get_data($!gt);
  }

  method get_rev {
    gegl_tile_get_rev($!gt);
  }

  method is_stored {
    so gegl_tile_is_stored($!gt);
  }

  method lock {
    gegl_tile_lock($!gt);
  }

  method mark_as_stored {
    gegl_tile_mark_as_stored($!gt);
  }

  method read_lock {
    gegl_tile_read_lock($!gt);
  }

  method read_unlock {
    gegl_tile_read_unlock($!gt);
  }

  method ref {
    gegl_tile_ref($!gt);
  }

  method set_data (gpointer $pixel_data, Int() $pixel_data_size) {
    my gint $p = $pixel_data_size;

    gegl_tile_set_data($!gt, $pixel_data, $p);
  }

  method set_data_full (
    gpointer $pixel_data,
    Int()    $pixel_data_size,
             &destroy_notify,
    gpointer $destroy_notify_data = gpointer
  ) {
    my gint $p = $pixel_data_size;

    gegl_tile_set_data_full(
      $!gt,
      $pixel_data,
      $p,
      &destroy_notify,
      $destroy_notify_data
    );
  }

  method set_rev (Int() $rev) {
    my guint $r = $rev;

    gegl_tile_set_rev($!gt, $r);
  }

  method set_unlock_notify (
             &unlock_notify,
    gpointer $unlock_notify_data = gpointer
  ) {
    gegl_tile_set_unlock_notify($!gt, &unlock_notify, $unlock_notify_data);
  }

  method store {
    gegl_tile_store($!gt);
  }

  method unlock {
    gegl_tile_unlock($!gt);
  }

  method unref {
    gegl_tile_unref($!gt);
  }

  method void {
    gegl_tile_void($!gt);
  }

}
