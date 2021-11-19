use v6.c;

use NativeCall;

use Cairo;

use GLib::Raw::Definitions;
use GLib::Raw::Object;
use GEGL::Raw::Definitions;

unit package GEGL::Raw::Structs;

# cw: Types need hand checks.

# class ColorDef is repr<CStruct> is export {
# 	has uint64  $!name;
# 	has float   $!r   ;
# 	has float   $!g   ;
# 	has float   $!b   ;
# 	has float   $!a   ;
# }
#
# class CtxBinding is repr<CStruct> is export {
# 	has uint8             $!nick          ;
# 	has uint8             $!command       ;
# 	has uint8             $!label         ;
# 	has CtxCb            $!cb            ;
# 	has void             $!cb_data       ;
# 	has CtxDestroyNotify $!destroy_notify;
# 	has void             $!destroy_data  ;
# }
#
# class CtxCairo is repr<CStruct> is export {
# 	has CtxImplementation $!vfuncs  ;
# 	has Ctx               $!ctx     ;
# 	has cairo_t           $!cr      ;
# 	has cairo_pattern_t   $!pat     ;
# 	has cairo_surface_t   $!image   ;
# 	has int               $!preserve;
# }
#
# class CtxEidInfo is repr<CStruct> is export {
# 	has uint8 $!eid   ;
# 	has int  $!frame ;
# 	has int  $!width ;
# 	has int  $!height;
# }
#
# class CtxGlyph is repr<CStruct> is export {
# 	has uint32_t $!index;
# 	has float    $!x    ;
# 	has float    $!y    ;
# }
#
# class CtxGradientStop is repr<CStruct> is export {
# 	has float    $!pos  ;
# 	has CtxColor $!color;
# }
#
# class CtxHasher is repr<CStruct> is export {
# 	has CtxRasterizer $!rasterizer ;
# 	has int           $!cols       ;
# 	has int           $!rows       ;
# 	has uint8_t       $!hashes     ;
# 	has CtxSHA1       $!sha1_fill  ;
# 	has CtxSHA1       $!sha1_stroke;
# }
#
# class CtxIntRectangle is repr<CStruct> is export {
# 	has int $!x     ;
# 	has int $!y     ;
# 	has int $!width ;
# 	has int $!height;
# }
#
# class CtxInternalFsEntry is repr<CStruct> is export {
# 	has uint8 $!path  ;
# 	has int  $!length;
# 	has uint8 $!data  ;
# }
#
# class CtxList is repr<CStruct> is export {
# 	has void    $!data;
# 	has CtxList $!next;
# }
#
# class CtxSpan is repr<CStruct> is export {
# 	has int $!from_prev;
# 	has int $!start    ;
# 	has int $!length   ;
# }
#
# class CtxString is repr<CStruct> is export {
# 	has uint8 $!str             ;
# 	has int   $!length          ;
# 	has int   $!utf8_length     ;
# 	has int   $!allocated_length;
# 	has int   $!is_line         ;
# }
#
# class CtxTermCell is repr<CStruct> is export {
# 	has uint8   $!utf8     ;
# 	has uint8_t $!fg       ;
# 	has uint8_t $!bg       ;
# 	has uint8   $!prev_utf8;
# 	has uint8_t $!prev_fg  ;
# 	has uint8_t $!prev_bg  ;
# }
#
# class CtxTermGlyph is repr<CStruct> is export {
# 	has uint32_t $!uniuint8;
# 	has int      $!col    ;
# 	has int      $!row    ;
# 	has uint8_t  $!rgba_bg;
# 	has uint8_t  $!rgba_fg;
# }
#
# class CtxTermLine is repr<CStruct> is export {
# 	has CtxTermCell $!cells ;
# 	has int         $!maxcol;
# 	has int         $!size  ;
# }
#
# class GeglAudioFragmentClass is repr<CStruct> is export {
# 	has GObjectClass $!parent_class;
# }
#
# class GeglBufferIterator is repr<CStruct> is export {
# 	has gint                   $!length;
# 	has GeglBufferIteratorPriv $!priv  ;
# 	has GeglBufferIteratorItem $!items ;
# }
#
# class GeglBufferIteratorItem is repr<CStruct> is export {
# 	has gpointer      $!data;
# 	has GeglRectangle $!roi ;
# }
#
# class GeglClTexture is repr<CStruct> is export {
# 	has cl_mem          $!data  ;
# 	has cl_image_format $!format;
# 	has gint            $!width ;
# 	has gint            $!height;
# }
#
# class GeglCurve is repr<CStruct> is export {
# 	has GObject $!parent_instance;
# }
#
# class GeglMetadataMap is repr<CStruct> is export {
# 	has guint8           $!local_name;
# 	has guint8           $!name      ;
# 	has GValueTransform $!transform ;
# }
#
# class GeglModuleInfo is repr<CStruct> is export {
# 	has guint32 $!abi_version;
# }
#
# class GeglOp is repr<CStruct> is export {
# 	has GEGL_OP_Parent $!parent_instance;
# 	has gpointer       $!properties     ;
# }
#
# class GeglOperation is repr<CStruct> is export {
# 	has GObject  $!parent_instance;
# 	has GeglNode $!node           ;
# }
#
# class GeglOperationAreaFilter is repr<CStruct> is export {
# 	has GeglOperationFilter $!parent_instance;
# 	has gint                $!left           ;
# 	has gint                $!right          ;
# 	has gint                $!top            ;
# 	has gint                $!bottom         ;
# }
#
# class GeglOperationComposer is repr<CStruct> is export {
# 	has GeglOperation $!parent_instance;
# }
#
# class GeglOperationFilter is repr<CStruct> is export {
# 	has GeglOperation $!parent_instance;
# }
#
# class GeglOperationMeta is repr<CStruct> is export {
# 	has GeglOperation $!parent_instance;
# }
#
# class GeglOperationMetaJson is repr<CStruct> is export {
# 	has GeglOperationMeta $!parent_instance;
# 	has gpointer          $!pad            ;
# }
#
# class GeglOperationMetaJsonClass is repr<CStruct> is export {
# 	has GeglOperationMetaClass $!parent_class;
# 	has gpointer               $!pad         ;
# }
#
# class GeglOperationPointComposer is repr<CStruct> is export {
# 	has GeglOperationComposer $!parent_instance;
# }
#
# class GeglOperationPointFilter is repr<CStruct> is export {
# 	has GeglOperationFilter $!parent_instance;
# }
#
# class GeglOperationPointRender is repr<CStruct> is export {
# 	has GeglOperationSource $!parent_instance;
# }
#
# class GeglOperationSink is repr<CStruct> is export {
# 	has GeglOperation $!parent_instance;
# }
#
# class GeglOperationSource is repr<CStruct> is export {
# 	has GeglOperation $!parent_instance;
# }
#
# class GeglOperationTemporal is repr<CStruct> is export {
# 	has GeglOperationFilter          $!parent_instance;
# 	has GeglOperationTemporalPrivate $!priv           ;
# }
#
# class GeglParamSpecDouble is repr<CStruct> is export {
# 	has GParamSpecDouble $!parent_instance;
# 	has gdouble          $!ui_minimum     ;
# 	has gdouble          $!ui_maximum     ;
# 	has gdouble          $!ui_gamma       ;
# 	has gdouble          $!ui_step_small  ;
# 	has gdouble          $!ui_step_big    ;
# 	has gint             $!ui_digits      ;
# }
#
# class GeglParamSpecEnum is repr<CStruct> is export {
# 	has GParamSpecEnum $!parent_instance;
# 	has GSList         $!excluded_values;
# }
#
# class GeglParamSpecFormat is repr<CStruct> is export {
# 	has GParamSpecPointer $!parent_instance;
# }
#
# class GeglParamSpecInt is repr<CStruct> is export {
# 	has GParamSpecInt $!parent_instance;
# 	has gint          $!ui_minimum     ;
# 	has gint          $!ui_maximum     ;
# 	has gdouble       $!ui_gamma       ;
# 	has gint          $!ui_step_small  ;
# 	has gint          $!ui_step_big    ;
# }
#
# class GeglParamSpecSeed is repr<CStruct> is export {
# 	has GParamSpecUInt $!parent_instance;
# 	has guint          $!ui_minimum     ;
# 	has guint          $!ui_maximum     ;
# }
#
# class GeglPath is repr<CStruct> is export {
# 	has GObject $!parent_instance;
# }
#
# class GeglPathItem is repr<CStruct> is export {
# 	has guint8         $!type ;
# 	has GeglPathPoint $!point;
# }
#
# class GeglPathList is repr<CStruct> is export {
# 	has GeglPathList $!next;
# 	has GeglPathItem $!d   ;
# }
#
# class GeglPathPoint is repr<CStruct> is export {
# 	has gfloat $!x;
# 	has gfloat $!y;
# }
#
# class GeglProperties is repr<CStruct> is export {
# 	has gpointer   $!user_data;
# 	has GeglRandom $!rand_name;
# }
#

class GeglTileSource is repr<CStruct> is export {
	has GObject               $!parent_instance;
	has GeglTileSourceCommand $!command        ;
	has gpointer              $!padding        ;
}

class GeglTileBackend is repr<CStruct> is export {
	has GeglTileSource         $!parent_instance;
	has gpointer               $!priv           ; #= GeglTileBackendPrivate
}
#
# class GeglTileBackendClass is repr<CStruct> is export {
# 	has GeglTileSourceClass $!parent_class;
# 	has gpointer            $!padding     ;
# }
#
# class GeglTileCopyParams is repr<CStruct> is export {
# 	has GeglBuffer $!dst_buffer;
# 	has gint       $!dst_x     ;
# 	has gint       $!dst_y     ;
# 	has gint       $!dst_z     ;
# }
#
# class GeglTileHandler is repr<CStruct> is export {
# 	has GeglTileSource         $!parent_instance;
# 	has GeglTileSource         $!source         ;
# 	has GeglTileHandlerPrivate $!priv           ;
# }
#
# class GeglTileHandlerClass is repr<CStruct> is export {
# 	has GeglTileSourceClass $!parent_class;
# }
#

#
# class GeglTileSourceClass is repr<CStruct> is export {
# 	has GObjectClass $!parent_class;
# 	has gpointer     $!padding     ;
# }
#
# class GfxState is repr<CStruct> is export {
# 	has int     $!action       ;
# 	has int     $!id           ;
# 	has int     $!buf_width    ;
# 	has int     $!buf_height   ;
# 	has int     $!format       ;
# 	has int     $!compression  ;
# 	has int     $!transmission ;
# 	has int     $!multichunk   ;
# 	has int     $!buf_size     ;
# 	has int     $!x            ;
# 	has int     $!y            ;
# 	has int     $!w            ;
# 	has int     $!h            ;
# 	has int     $!x_cell_offset;
# 	has int     $!y_cell_offset;
# 	has int     $!columns      ;
# 	has int     $!rows         ;
# 	has int     $!z_index      ;
# 	has int     $!delete       ;
# 	has uint8_t $!data         ;
# 	has int     $!data_size    ;
# }
#
# class Image is repr<CStruct> is export {
# 	has int     $!kitty_format;
# 	has int     $!width       ;
# 	has int     $!height      ;
# 	has int     $!id          ;
# 	has int     $!eid_no      ;
# 	has int     $!size        ;
# 	has uint8_t $!data        ;
# }
#
# class Interned is repr<CStruct> is export {
# 	has uint64_t $!hash  ;
# 	has uint8     $!string;
# }
#
# class Mice is repr<CStruct> is export {
# 	has int    $!fd        ;
# 	has double $!x         ;
# 	has double $!y         ;
# 	has int    $!button    ;
# 	has int    $!prev_state;
# }
#
# class NPDBone is repr<CStruct> is export {
# 	has gint     $!num_of_points;
# 	has NPDPoint $!points       ;
# 	has gfloat   $!weights      ;
# }
#
# class NPDImage is repr<CStruct> is export {
# 	has gint            $!width       ;
# 	has gint            $!height      ;
# 	has NPDPoint        $!position    ;
# 	has gint            $!rowstride   ;
# 	has gint            $!length      ;
# 	has GeglBuffer      $!gegl_buffer ;
# 	has guuint8          $!buffer      ;
# 	has gfloat          $!buffer_f    ;
# 	has Babl            $!format      ;
# 	has GeglSamplerType $!sampler_type;
# }
#
# class NPDOverlappingPoints is repr<CStruct> is export {
# 	has gint     $!num_of_points ;
# 	has NPDPoint $!representative;
# 	has NPDPoint $!points        ;
# }
#
# class NPDPoint is repr<CStruct> is export {
# 	has gfloat               $!x                 ;
# 	has gfloat               $!y                 ;
# 	has gboolean             $!fixed             ;
# 	has gfloat               $!weight            ;
# 	has gint                 $!index             ;
# 	has NPDBone              $!current_bone      ;
# 	has NPDBone              $!reference_bone    ;
# 	has NPDPoint             $!counterpart       ;
# 	has NPDOverlappingPoints $!overlapping_points;
# }
#
# class VtPty is repr<CStruct> is export {
# 	has int   $!pty ;
# 	has pid_t $!pid ;
# 	has int   $!done;
# }
#
# class cl_buffer_region is repr<CStruct> is export {
# 	has size_t $!origin;
# 	has size_t $!size  ;
# }
#
# class cl_image_format is repr<CStruct> is export {
# 	has cl_channel_order $!image_channel_order    ;
# 	has cl_channel_type  $!image_channel_data_type;
# }

class GeglBufferMatrix3 is repr<CStruct> is export {
  HAS gdouble          @coeff[9] is CArray;
}

class GeglBufferMatrix2 is repr<CStruct> is export {
  HAS gdouble          @coeff[4] is CArray;
}
