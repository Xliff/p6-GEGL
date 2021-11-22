use v6.c;

use Method::Also;

use GEGL::Raw::Types;
use GEGL::Raw::Buffer;

use GLib::Roles::Object;

our subset GeglBufferAncestry is export of Mu
  where GeglBuffer | GObject;

class GEGL::Buffer {
  also does GLib::Roles::Object;

  has GeglBuffer $!gb;

  submethod BUILD ( :$gegl-buffer ) {
    self.setGeglBuffer($gegl-buffer) if $gegl-buffer;
  }

  method setGeglBuffer (GeglBufferAncestry $_) {
    my $to-parent;

    $!gb = do {
      when GeglBuffer {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GeglBuffer, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GEGL::Raw::Definitions::GeglBuffer
    is also<GeglBuffer>
  { $!gb }

  multi method new (GeglBufferAncestry $gegl-buffer, :$ref = True) {
    return Num unless $gegl-buffer;

    my $o = self.bless( :$gegl-buffer );
    $o.ref if $ref;
    $o;
  }
  multi method new (GeglRectangle() $extent, Babl() $format) {
    my $gegl-buffer = gegl_buffer_new($extent, $format);

    $gegl-buffer ?? self.bless( :$gegl-buffer ) !! Nil;
  }

  method new_for_backend (
    GeglRectangle()   $extent,
    GeglTileBackend() $backend
  )
    is also<new-for-backend>
  {
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

  method add_handler (gpointer $handler) is also<add-handler> {
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

  method create_sub_buffer (GeglRectangle() $extent)
    is also<create-sub-buffer>
  {
    gegl_buffer_create_sub_buffer($!gb, $extent);
  }

  method dup {
    gegl_buffer_dup($!gb);
  }

  method flush {
    gegl_buffer_flush($!gb);
  }

  method flush_ext (GeglRectangle() $rect) is also<flush-ext> {
    gegl_buffer_flush_ext($!gb, $rect);
  }

  method freeze_changed is also<freeze-changed> {
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

  method get_abyss is also<get-abyss> {
    gegl_buffer_get_abyss($!gb);
  }

  method get_extent is also<get-extent> {
    gegl_buffer_get_extent($!gb);
  }

  method get_format is also<get-format> {
    gegl_buffer_get_format($!gb);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gegl_buffer_get_type, $n, $t );
  }

  method remove_handler (gpointer $handler) is also<remove-handler> {
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
  )
    is also<sample-at-level>
  {
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

  method sample_cleanup is also<sample-cleanup> {
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

  method set_abyss (GeglRectangle() $abyss) is also<set-abyss> {
    gegl_buffer_set_abyss($!gb, $abyss);
  }

  method set_color_from_pixel (
    GeglRectangle() $rect,
    gpointer        $pixel,
    Babl()          $pixel_format
  )
    is also<set-color-from-pixel>
  {
    gegl_buffer_set_color_from_pixel($!gb, $rect, $pixel, $pixel_format);
  }

  method set_extent (GeglRectangle() $extent) is also<set-extent> {
    gegl_buffer_set_extent($!gb, $extent);
  }

  method set_format (Babl() $format) is also<set-format> {
    gegl_buffer_set_format($!gb, $format);
  }

  method set_pattern (
    GeglRectangle() $rect,
    GeglBuffer()    $pattern,
    Int()           $x_offset,
    Int()           $y_offset
  )
    is also<set-pattern>
  {
    my gint ($xo, $yo) = ($x_offset, $y_offset);

    gegl_buffer_set_pattern($!gb, $rect, $pattern, $xo, $yo);
  }

  method share_storage (GeglBuffer() $buffer2) is also<share-storage> {
    gegl_buffer_share_storage($!gb, $buffer2);
  }

  method signal_connect (Str $detailed_signal, &c_handler, gpointer $data)
    is also<signal-connect>
  {
    gegl_buffer_signal_connect(
      $!gb,
      $detailed_signal,
      cast(gpointer, &c_handler),
      $data
    );
  }

  method thaw_changed is also<thaw-changed> {
    gegl_buffer_thaw_changed($!gb);
  }

}

our subset GeglSamplerAncestry is export of Mu
  where GeglSampler | GObject;

class GEGL::Sampler {
  also does GLib::Roles::Object;

  has GeglSampler $!gs;

  submethod BUILD ( :$gegl-buffer ) {
    self.setGeglSampler($gegl-buffer) if $gegl-buffer;
  }

  method setGeglSampler (GeglSamplerAncestry $_) {
    my $to-parent;

    $!gs = do {
      when GeglBuffer {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GeglSampler, $_);
      }
    }
    self!setObject($to-parent);
  }

  multi method GEGL::Raw::Definitions::GeglSampler
    is also<GeglSampler>
  { $!gs }

  multi method new (GeglSamplerAncestry $gegl-sampler, :$ref = True) {
    return Num unless $gegl-sampler;

    my $o = self.bless( :$gegl-sampler );
    $o.ref if $ref;
    $o;
  }
  multi method new (GeglBuffer() $buffer, Babl() $format, Int() $sampler_type) {
    my GeglSamplerType $s = $sampler_type;

    my $gegl-sampler = gegl_buffer_sampler_new($buffer, $format, $s);

    $gegl-sampler ?? self.bless( :$gegl-sampler ) !! Nil;
  }

  method new_at_level (
    GeglBuffer() $buffer,
    Babl()       $format,
    Int()        $sampler_type,
    Int()        $level
  )
    is also<new-at-level>
  {
    my GeglSamplerType $s = $sampler_type;
    my gint            $l = $level;

    my $gegl-sampler = gegl_buffer_sampler_new_at_level(
      $buffer,
      $format,
      $s,
      $l
    );

    $gegl-sampler ?? self.bless( :$gegl-sampler ) !! Nil;
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

  method get_context_rect is also<get-context-rect> {
    gegl_sampler_get_context_rect($!gs);
  }

  method get_fun is also<get-fun> {
    gegl_sampler_get_fun($!gs);
  }

}

class GEGL::Buffer::Linear is GEGL::Buffer {

  method new (Babl() $format) {
    my $gegl-buffer = gegl_buffer_linear_new($format);

    $gegl-buffer ?? self.bless( :$gegl-buffer ) !! Nil;
  }

  method new_from_data (
    Babl()          $format,
    GeglRectangle() $extent,
    Int()           $rowstride,
    GDestroyNotify  $destroy_fn,
    gpointer        $destroy_fn_data
  )
    is also<new-from-data>
  {
    my gint $r = $rowstride;

    my $gegl-buffer = gegl_buffer_linear_new_from_data(
      self.GeglBuffer,
      $format,
      $extent,
      $r,
      $destroy_fn,
      $destroy_fn_data
    );

    $gegl-buffer ?? self.bless( :$gegl-buffer ) !! Nil;
  }

  method open (GeglRectangle() $extent, $rowstride is rw, Babl() $format) {
    my $gegl-buffer = gegl_buffer_linear_open(
      $extent,
      $rowstride,
      $format
    );

    $gegl-buffer ?? self.bless( :$gegl-buffer ) !! Nil;
  }

  method close (gpointer $linear) {
    gegl_buffer_linear_close(self.GeglBuffer, $linear);
  }

}
