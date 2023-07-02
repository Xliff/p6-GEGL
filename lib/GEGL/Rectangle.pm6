use v6.c;

use GEGL::Raw::Types;
use GEGL::Raw::Rectangle;

use GLib::Roles::Implementor;

# BOXED

class GEGL::Rectangle {
  also does GLib::Roles::Implementor;

  has GeglRectangle $!gr is implementor;

  submethod BUILD ( :$gegl-rectangle ) {
    $!gr = $gegl-rectangle if $gegl-rectangle;
  }

  method new (gint $x, gint $y, guint $width, guint $height) {
    my gint  ($xx, $yy)      = ($x, $y);
    my guint ($w, $h)        = ($width, $height);
    my       $gegl-rectangle = gegl_rectangle_new($xx, $yy, $w, $h);

    $gegl-rectangle ?? self.bless( :$gegl-rectangle ) !! Nil;
  }

  multi method align (
    GeglRectangle() $tile,
    Int()           $alignment,
                    :$raw       = False
  ) {
    my $d  = GeglRectangle.new;

    return-with-all(
      GEGL::Rectangle.align($d, $!gr, $tile, $alignment, :$raw, :all)
    )
  }
  multi method align (
    GEGL::Rectangle:U:

    GeglRectangle() $dest,
    GeglRectangle() $rectangle,
    GeglRectangle() $tile,
    Int()           $alignment,
                    :$raw      = False,
                    :$all      = False
  ) {
    my GeglRectangleAlignment $a = $alignment;

    my $rv = gegl_rectangle_align($dest, $rectangle, $tile, $a);

    my $ro = propReturnObject(
      $dest,
      $raw,
      |GEGL::Rectangle.getTypePair
    );

    $all.not ?? $rv !! ($rv, $ro);
  }

  multi method align_to_buffer (
    GeglBuffer()    $buffer,
    Int()           $alignment,
                    :$raw        = False
  ) {
    my $d = GeglRectangle.new;

    return-with-all(
      GEGL::Rectangle.align_to_buffer(
        $d,
        $!gr,
        $buffer,
        $alignment,
        :$raw,
        :all
      )
    )
  }
  multi method align_to_buffer (
    GEGL::Rectangle:U:

    GeglRectangle() $dest,
    GeglRectangle() $rectangle,
    GeglBuffer()    $buffer,
    Int()           $alignment,
                    :$raw        = False,
                    :$all        = False
  ) {
    my GeglRectangleAlignment $a = $alignment;

    my $rv = gegl_rectangle_align_to_buffer($dest, $rectangle, $buffer, $a);

    my $ro = propReturnObject(
      $dest,
      $raw,
      |GEGL::Rectangle.getTypePair
    );

    $all.not ?? $rv !! ($rv, $ro);
  }


  multi method bounding_box (
    GeglRectangle() $source2,
                    :$raw     = False
  ) {
    my $d = GeglRectangle.new;

    GEGL::Rectangle.bounding_box($d, $!gr, $source2, :$raw);
  }
  multi method bounding_box (
    GEGL::Rectangle:U:

    GeglRectangle() $dest,
    GeglRectangle() $source1,
    GeglRectangle() $source2,
                    :$raw     = False
  ) {
    gegl_rectangle_bounding_box($dest, $source1, $source2);

    propReturnObject(
      $dest,
      $raw,
      |GEGL::Rectangle.getTypePair
    )
  }

  method contains (GeglRectangle() $child) {
    so gegl_rectangle_contains($!gr, $child);
  }

  multi method copy ( :$raw = False ) {
    my $d = GeglRectangle.new;

    GEGL::Rectangle.copy($d, $!gr, :$raw);
  }
  multi method copy (
    GeglRectangle() $dest,
    GeglRectangle() $source,
                    :$raw    = False
  ) {
    propReturnObject(
      gegl_rectangle_copy($dest, $source),
      $raw,
      |GEGL::Rectangle.getTypePair
    );
  }

  method dump {
    gegl_rectangle_dump($!gr);
  }

  method dup ( :$raw = False ) {
    propReturnObject(
      gegl_rectangle_dup($!gr),
      $raw,
      |GEGL::Rectangle.getTypePair
    );
  }

  method equal (GeglRectangle() $rectangle2) {
    so gegl_rectangle_equal($!gr, $rectangle2);
  }

  method equal_coords (Int() $x, Int() $y, Int() $width, Int() $height) {
    my gint  ($xx, $yy)      = ($x, $y);
    my guint ($w, $h)        = ($width, $height);

    so gegl_rectangle_equal_coords($!gr, $x, $y, $w, $h);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gegl_rectangle_get_type, $n, $t );
  }

  method infinite_plane (GEGL::Rectangle:U: :$raw = False) {
    propReturnObject(
      gegl_rectangle_infinite_plane(),
      $raw,
      |GEGL::Rectangle.getTypePair
    );
  }

  multi method intersect (
    GeglRectangle() $src2
                    :$raw   = False,
                    :$all   = False
  ) {
    my $d = GeglRectangle.new;

    GEGL::Rectangle.intersect($d, $!gr, $src2, :$raw, :$all)
  }
  multi method intersect (
    GEGL::Rectangle:U:

    GeglRectangle() $dest,
    GeglRectangle() $src1,
    GeglRectangle() $src2,
                    :$raw   = False,
                    :$all   = False
  ) {
    my $nr = gegl_rectangle_intersect($dest, $src1, $src2);

    my $ro = propReturnObject(
      $dest,
      $raw,
      |GEGL::Rectangle.getType
    );

    $all.not ?? $ro !! ($nr, $ro);
  }

  method is_empty {
    so gegl_rectangle_is_empty($!gr);
  }

  method is_infinite_plane {
    so gegl_rectangle_is_infinite_plane($!gr);
  }

  method set (Int() $x, Int() $y, Int() $width, Int() $height) {
    my gint  ($xx, $yy)      = ($x, $y);
    my guint ($w, $h)        = ($width, $height);

    gegl_rectangle_set($!gr, $x, $y, $width, $height);
  }

  multi method subtract (
    GeglRectangle() $subtrahend,
                    :$raw        = False,
                    :$all        = False
  ) {
    my $d = GeglRectangle.new;

    GEGL::Rectangle.subtract($d, $!gr, $subtrahend, :$raw, :$all);
  }
  multi method subtract (
    GEGL::Rectangle:U:

    GeglRectangle() $dest,
    GeglRectangle() $minuend,
    GeglRectangle() $subtrahend,
                    :$raw        = False,
                    :$all        = False
  ) {
    my $nr = gegl_rectangle_subtract($dest, $minuend, $subtrahend);

    my $ro = propReturnObject(
      $dest,
      $raw,
      |GEGL::Rectangle.getTypePair
    );

    $all.not ?? $ro !! ($nr, $ro);
  }

  method subtract_bounding_box (
    GeglRectangle() $minuend,
    GeglRectangle() $subtrahend
  ) {
    gegl_rectangle_subtract_bounding_box($!gr, $minuend, $subtrahend);
  }

  multi method xor (GeglRectangle() $source2, :$raw = False, :$all = False) {
    my $d = GeglRectangle.new;

    GEGL::Rectangle.xor($d, $!gr, $source2, :$raw, :$all)
  }
  multi method xor (
    GEGL::Rectangle:U:

    GeglRectangle() $dest,
    GeglRectangle() $src1,
    GeglRectangle() $src2,
                    :$raw  = False,
                    :$all  = False
  ) {
    my $nr = gegl_rectangle_xor($dest, $src1, $src2);

    my $ro = propReturnObject(
      $dest,
      $raw,
      |GEGL::Rectangle.getTypePair
    );

    $all.not ?? $ro !! ($nr, $ro);
  }
}
