use v6.c;

use GEGL::Raw::Types;
use GEGL::Raw::Buffer;

use GLib::Roles::Object;

class GEGL::Buffer {
  also does GLib::Roles::Object;

  has GeglBuffer $!gb;

  method new (GeglRectangle() $extent, Babl() $format) {
    my $gegl-buffer = gegl_buffer_new($extent, $format);

    $gegl-buffer ?? self.bless( :$gegl-buffer ) !! Nil;
  }

  method new_for_backend (
    GeglRectangle()   $extent,
    GeglTileBackend() $backend
  ) {
    my $gegl-buffer = gegl_buffer_new_for_backend($extent, $backend);

    $gegl-buffer ?? self.bless( :$gegl-buffer ) !! Nil;
  }

  method load (Str() $path) {
    my $gegl-buffer = gegl_buffer_load($path);

    $gegl-buffer ?? self.bless( :$gegl-buffer ) !! Nil
  }

  method open (Str() $path) {
    my $gegl-buffer = gegl_buffer_open($path);

    $gegl-buffer ?? self.bless( :$gegl-buffer ) !! Nil;
  }

  method add_handler (gpointer $handler) {
    gegl_buffer_add_handler($!gb, $handler);
  }

  method clear (GeglRectangle() $roi) {
    gegl_buffer_clear($!gb, $roi);
  }

  method copy (
    GeglRectangle() $src_rect,
    Int()           $repeat_mode,
    GeglBuffer()    $dst,
    GeglRectangle() $dst_rect
  ) {
    my GeglAbyssPolicy $rm = $repeat_mode;

    gegl_buffer_copy($!gb, $src_rect, $rm, $dst, $dst_rect);
  }

  method create_sub_buffer (GeglRectangle() $extent) {
    gegl_buffer_create_sub_buffer($!gb, $extent);
  }

  method dup {
    gegl_buffer_dup($!gb);
  }

  method flush {
    gegl_buffer_flush($!gb);
  }

  method flush_ext (GeglRectangle() $rect) {
    gegl_buffer_flush_ext($!gb, $rect);
  }

  method freeze_changed {
    gegl_buffer_freeze_changed($!gb);
  }

  method get (
    GeglRectangle() $rect,
    Num()           $scale,
    Babl()          $format,
    gpointer        $dest,
    Int()           $rowstride,
    Int()           $repeat_mode
  ) {
    my gdouble         $s  = $scale;
    my gint            $r  = $rowstride;
    my GeglAbyssPolicy $rm = $repeat_mode;

    gegl_buffer_get($!gb, $rect, $s, $format, $dest, $r, $rm);
  }

  method get_abyss {
    gegl_buffer_get_abyss($!gb);
  }

  method get_extent {
    gegl_buffer_get_extent($!gb);
  }

  method get_format {
    gegl_buffer_get_format($!gb);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gegl_buffer_get_type, $n, $t );
  }

  method remove_handler (gpointer $handler) {
    gegl_buffer_remove_handler($!gb, $handler);
  }

  method sample (
    Num()               $x,
    Num()               $y,
    GeglBufferMatrix2() $scale,
    gpointer            $dest,
    Babl()              $format,
    Int()               $sampler_type,
    Int()               $repeat_mode
  ) {
    my gdouble         ($xx, $yy) = ($x, $y);
    my GeglSamplerType $s         = $sampler_type;
    my GeglAbyssPolicy $rm        = $repeat_mode;

    gegl_buffer_sample($!gb, $xx, $yy, $scale, $dest, $format, $s, $rm);
  }

  method sample_at_level (
    Num()               $x,
    Num()               $y,
    GeglBufferMatrix2() $scale,
    gpointer            $dest,
    Babl                $format,
    Int()               $level,
    Int()               $sampler_type,
    Int()               $repeat_mode
  ) {
    my gdouble         ($xx, $yy) = ($x, $y);
    my gint            $l         = $level;
    my GeglSamplerType $s         = $sampler_type;
    my GeglAbyssPolicy $rm        = $repeat_mode;

    gegl_buffer_sample_at_level(
      $!gb,
      $xx,
      $yy,
      $scale,
      $dest,
      $format,
      $l,
      $s,
      $rm
    );
  }

  method sample_cleanup {
    gegl_buffer_sample_cleanup($!gb);
  }

  method save (Str() $path, GeglRectangle() $roi) {
    gegl_buffer_save($!gb, $path, $roi);
  }

  method set (
    GeglRectangle() $rect,
    Int()           $mipmap_level,
    Babl()          $format,
    gpointer        $src,
    Int()           $rowstride
  ) {
    my gint ($m, $r) = ($mipmap_level, $rowstride);

    gegl_buffer_set($!gb, $rect, $m, $format, $src, $r);
  }

  method set_abyss (GeglRectangle() $abyss) {
    gegl_buffer_set_abyss($!gb, $abyss);
  }

  method set_color_from_pixel (
    GeglRectangle() $rect,
    gpointer        $pixel,
    Babl()          $pixel_format
  ) {
    gegl_buffer_set_color_from_pixel($!gb, $rect, $pixel, $pixel_format);
  }

  method set_extent (GeglRectangle() $extent) {
    gegl_buffer_set_extent($!gb, $extent);
  }

  method set_format (Babl() $format) {
    gegl_buffer_set_format($!gb, $format);
  }

  method set_pattern (
    GeglRectangle() $rect,
    GeglBuffer()    $pattern,
    Int()           $x_offset,
    Int()           $y_offset
  ) {
    my gint ($xo, $yo) = ($x_offset, $y_offset);

    gegl_buffer_set_pattern($!gb, $rect, $pattern, $xo, $yo);
  }

  method share_storage (GeglBuffer() $buffer2) {
    gegl_buffer_share_storage($!gb, $buffer2);
  }

  method signal_connect (Str $detailed_signal, &c_handler, gpointer $data) {
    gegl_buffer_signal_connect(
      $!gb,
      $detailed_signal,
      cast(gpointer, &c_handler),
      $data
    );
  }

  method thaw_changed {
    gegl_buffer_thaw_changed($!gb);
  }

}

class GEGL::Sampler {
  also does GLib::Roles::Object;

  has GeglSampler $!gs;

  method new (GeglBuffer() $buffer, Babl() $format, Int() $sampler_type) {
    my GeglSamplerType $s = $sampler_type;

    my $gegl-buffer-sampler = gegl_buffer_sampler_new($buffer, $format, $s);

    $gegl-buffer-sampler ?? self.bless( :$gegl-buffer-sampler ) !! Nil;
  }

  method new_at_level (
    GeglBuffer() $buffer,
    Babl()       $format,
    Int()        $sampler_type,
    Int()        $level
  ) {
    my GeglSamplerType $s = $sampler_type;
    my gint            $l = $level;

    gegl_buffer_sampler_new_at_level($buffer, $format, $s, $l);
  }

  method get (
    Num()               $x,
    Num()               $y,
    GeglBufferMatrix2() $scale,
    gpointer            $output,
    Int()               $repeat_mode
  ) {
    my gdouble         ($xx, $yy) = ($x, $y);
    my GeglAbyssPolicy $rm        = $repeat_mode;

    gegl_sampler_get($!gs, $xx, $yy, $scale, $output, $repeat_mode);
  }

  method get_context_rect {
    gegl_sampler_get_context_rect($!gs);
  }

  method get_fun {
    gegl_sampler_get_fun($!gs);
  }

}

class GEGL::Buffer::Linear is GEGL::Buffer {

  method close (gpointer $linear) {
    gegl_buffer_linear_close(self.GeglBuffer, $linear);
  }

  method new (Babl() $format) {
    gegl_buffer_linear_new($format);
  }

  method new_from_data (
    Babl()          $format,
    GeglRectangle() $extent,
    Int()           $rowstride,
    GDestroyNotify  $destroy_fn,
    gpointer         $destroy_fn_data
  ) {
    my gint $r = $rowstride;

    gegl_buffer_linear_new_from_data(
      self.GeglBuffer,
      $format,
      $extent,
      $r,
      $destroy_fn,
      $destroy_fn_data
    );
  }

  method open (GeglRectangle() $extent, $rowstride is rw, Babl() $format) {
    gegl_buffer_linear_open(self.GeglBuffer, $extent, $rowstride, $format);
  }

}
