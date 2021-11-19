use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GEGL::Raw::Definitions;
use GEGL::Raw::Enums;
use GEGL::Raw::Structs;

unit package GEGL::Raw::Buffer;

### /usr/include/gegl-0.4/gegl-buffer.h

sub gegl_buffer_add_handler (GeglBuffer $buffer, gpointer $handler)
  is native(gegl)
  is export
{ * }

sub gegl_buffer_clear (GeglBuffer $buffer, GeglRectangle $roi)
  is native(gegl)
  is export
{ * }

sub gegl_buffer_copy (
  GeglBuffer      $src,
  GeglRectangle   $src_rect,
  GeglAbyssPolicy $repeat_mode,
  GeglBuffer      $dst,
  GeglRectangle   $dst_rect
)
  is native(gegl)
  is export
{ * }

sub gegl_buffer_create_sub_buffer (GeglBuffer $buffer, GeglRectangle $extent)
  returns GeglBuffer
  is native(gegl)
  is export
{ * }

sub gegl_buffer_dup (GeglBuffer $buffer)
  returns GeglBuffer
  is native(gegl)
  is export
{ * }

sub gegl_buffer_flush (GeglBuffer $buffer)
  is native(gegl)
  is export
{ * }

sub gegl_buffer_flush_ext (GeglBuffer $buffer, GeglRectangle $rect)
  is native(gegl)
  is export
{ * }

sub gegl_buffer_freeze_changed (GeglBuffer $buffer)
  is native(gegl)
  is export
{ * }

sub gegl_sampler_get (
  GeglSampler       $sampler,
  gdouble           $x,
  gdouble           $y,
  GeglBufferMatrix2 $scale,
  Pointer           $output,
  GeglAbyssPolicy   $repeat_mode
)
  is native(gegl)
  is export
{ * }

sub gegl_sampler_get_context_rect (GeglSampler $sampler)
  returns GeglRectangle
  is native(gegl)
  is export
{ * }

sub gegl_sampler_get_fun (GeglSampler $sampler)
  returns gpointer # GeglSamplerGetFun
  is native(gegl)
  is export
{ * }

sub gegl_buffer_get (
  GeglBuffer      $buffer,
  GeglRectangle   $rect,
  gdouble         $scale,
  Babl            $format,
  gpointer        $dest,
  gint            $rowstride,
  GeglAbyssPolicy $repeat_mode
)
  is native(gegl)
  is export
{ * }

sub gegl_buffer_get_abyss (GeglBuffer $buffer)
  returns GeglRectangle
  is native(gegl)
  is export
{ * }

sub gegl_buffer_get_extent (GeglBuffer $buffer)
  returns GeglRectangle
  is native(gegl)
  is export
{ * }

sub gegl_buffer_get_format (GeglBuffer $buffer)
  returns Babl
  is native(gegl)
  is export
{ * }

sub gegl_buffer_get_type ()
  returns GType
  is native(gegl)
  is export
{ * }

sub gegl_buffer_linear_close (GeglBuffer $buffer, gpointer $linear)
  is native(gegl)
  is export
{ * }

sub gegl_buffer_linear_new (GeglRectangle $extent, Babl $format)
  returns GeglBuffer
  is native(gegl)
  is export
{ * }

sub gegl_buffer_linear_new_from_data (
  gpointer       $data,
  Babl           $format,
  GeglRectangle  $extent,
  gint           $rowstride,
  GDestroyNotify $destroy_fn,
  gpointer       $destroy_fn_data
)
  returns GeglBuffer
  is native(gegl)
  is export
{ * }

sub gegl_buffer_linear_open (
  GeglBuffer    $buffer,
  GeglRectangle $extent,
  gint          $rowstride is rw,
  Babl          $format
)
  returns Pointer
  is native(gegl)
  is export
{ * }

sub gegl_buffer_load (Str $path)
  returns GeglBuffer
  is native(gegl)
  is export
{ * }

sub gegl_buffer_new (GeglRectangle $extent, Babl $format)
  returns GeglBuffer
  is native(gegl)
  is export
{ * }

sub gegl_buffer_new_for_backend (GeglRectangle $extent, GeglTileBackend $backend)
  returns GeglBuffer
  is native(gegl)
  is export
{ * }

sub gegl_buffer_open (Str $path)
  returns GeglBuffer
  is native(gegl)
  is export
{ * }

sub gegl_buffer_remove_handler (GeglBuffer $buffer, gpointer $handler)
  is native(gegl)
  is export
{ * }

sub gegl_buffer_sample (
  GeglBuffer        $buffer,
  gdouble           $x,
  gdouble           $y,
  GeglBufferMatrix2 $scale,
  gpointer          $dest,
  Babl              $format,
  GeglSamplerType   $sampler_type,
  GeglAbyssPolicy   $repeat_mode
)
  is native(gegl)
  is export
{ * }

sub gegl_buffer_sample_at_level (
  GeglBuffer        $buffer,
  gdouble           $x,
  gdouble           $y,
  GeglBufferMatrix2 $scale,
  gpointer          $dest,
  Babl              $format,
  gint              $level,
  GeglSamplerType   $sampler_type,
  GeglAbyssPolicy   $repeat_mode
)
  is native(gegl)
  is export
{ * }

sub gegl_buffer_sample_cleanup (GeglBuffer $buffer)
  is native(gegl)
  is export
{ * }

sub gegl_buffer_sampler_new (
  GeglBuffer      $buffer,
  Babl            $format,
  GeglSamplerType $sampler_type
)
  returns GeglSampler
  is native(gegl)
  is export
{ * }

sub gegl_buffer_sampler_new_at_level (
  GeglBuffer      $buffer,
  Babl            $format,
  GeglSamplerType $sampler_type,
  gint            $level
)
  returns GeglSampler
  is native(gegl)
  is export
{ * }

sub gegl_buffer_save (GeglBuffer $buffer, Str $path, GeglRectangle $roi)
  is native(gegl)
  is export
{ * }

sub gegl_buffer_set (
  GeglBuffer    $buffer,
  GeglRectangle $rect,
  gint          $mipmap_level,
  Babl          $format,
  Pointer       $src,
  gint          $rowstride
)
  is native(gegl)
  is export
{ * }

sub gegl_buffer_set_abyss (GeglBuffer $buffer, GeglRectangle $abyss)
  returns uint32
  is native(gegl)
  is export
{ * }

sub gegl_buffer_set_color_from_pixel (
  GeglBuffer    $buffer,
  GeglRectangle $rect,
  gpointer      $pixel,
  Babl          $pixel_format
)
  is native(gegl)
  is export
{ * }

sub gegl_buffer_set_extent (GeglBuffer $buffer, GeglRectangle $extent)
  returns uint32
  is native(gegl)
  is export
{ * }

sub gegl_buffer_set_format (GeglBuffer $buffer, Babl $format)
  returns Babl
  is native(gegl)
  is export
{ * }

sub gegl_buffer_set_pattern (
  GeglBuffer    $buffer,
  GeglRectangle $rect,
  GeglBuffer    $pattern,
  gint          $x_offset,
  gint          $y_offset
)
  is native(gegl)
  is export
{ * }

sub gegl_buffer_share_storage (GeglBuffer $buffer1, GeglBuffer $buffer2)
  returns uint32
  is native(gegl)
  is export
{ * }

sub gegl_buffer_signal_connect (
  GeglBuffer $buffer,
  Str        $detailed_signal,
  gpointer   $c_handler,        # Is multi-signature!.
  gpointer   $data
)
  returns glong
  is native(gegl)
  is export
{ * }

sub gegl_buffer_thaw_changed (GeglBuffer $buffer)
  is native(gegl)
  is export
{ * }
