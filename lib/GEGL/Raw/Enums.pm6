use v6.c;

use GLib::Raw::Definitions;

unit package GEGL::Raw::Enums;

constant CtxParser is export := guint32;
our enum CtxParserEnum is export (
  CTX_PARSER_NEUTRAL                => 0,
  'CTX_PARSER_NUMBER',
  'CTX_PARSER_NEGATIVE_NUMBER',
  'CTX_PARSER_WORD',
  'CTX_PARSER_COMMENT',
  'CTX_PARSER_STRING_APOS',
  'CTX_PARSER_STRING_QUOT',
  'CTX_PARSER_STRING_APOS_ESCAPED',
  'CTX_PARSER_STRING_QUOT_ESCAPED',
  'CTX_PARSER_STRING_A85',
  'CTX_PARSER_STRING_YENC'
);

constant CtxClientFlags is export := guint32;
our enum CtxClientFlagsEnum is export (
  ITK_CLIENT_UI_RESIZABLE => 1+<0,
  ITK_CLIENT_CAN_LAUNCH   => 1+<1,
  ITK_CLIENT_MAXIMIZED    => 1+<2,
  ITK_CLIENT_ICONIFIED    => 1+<3,
  ITK_CLIENT_SHADED       => 1+<4,
  ITK_CLIENT_TITLEBAR     => 1+<5,
);

constant CtxCovPath is export := guint32;
our enum CtxCovPathEnum is export (
  CTX_COV_PATH_FALLBACK         => 0,
  'CTX_COV_PATH_OVER',
  'CTX_COV_PATH_COPY',
  'CTX_COV_PATH_COPY_FRAGMENT',
  'CTX_COV_PATH_OVER_FRAGMENT'
);

constant CtxFillRule is export := guint32;
our enum CtxFillRuleEnum is export <
  CTX_FILL_RULE_WINDING
  CTX_FILL_RULE_EVEN_ODD
>;

constant CtxLineCap is export := guint32;
our enum CtxLineCapEnum is export (
  CTX_CAP_NONE   => 0,
  CTX_CAP_ROUND  => 1,
  CTX_CAP_SQUARE => 2,
);

constant CtxLineJoin is export := guint32;
our enum CtxLineJoinEnum is export (
  CTX_JOIN_BEVEL => 0,
  CTX_JOIN_ROUND => 1,
  CTX_JOIN_MITER => 2,
);

constant CtxOutputmode is export := guint32;
our enum CtxOutputmodeEnum is export <
  CTX_OUTPUT_MODE_QUARTER
  CTX_OUTPUT_MODE_BRAILLE
  CTX_OUTPUT_MODE_SIXELS
  CTX_OUTPUT_MODE_GRAYS
  CTX_OUTPUT_MODE_CTX
  CTX_OUTPUT_MODE_CTX_COMPACT
  CTX_OUTPUT_MODE_UI
>;

constant CtxPCM is export := guint32;
our enum CtxPCMEnum is export <
  CTX_f32
  CTX_f32S
  CTX_s16
  CTX_s16S
>;

constant CtxPorterDuffFactor is export := guint32;
our enum CtxPorterDuffFactorEnum is export <
  CTX_PORTER_DUFF_0
  CTX_PORTER_DUFF_1
  CTX_PORTER_DUFF_ALPHA
  CTX_PORTER_DUFF_1_MINUS_ALPHA
>;

constant CtxTermMode is export := guint32;
our enum CtxTermModeEnum is export <
  CTX_TERM_ASCII
  CTX_TERM_ASCII_MONO
  CTX_TERM_SEXTANT
  CTX_TERM_BRAILLE_MONO
  CTX_TERM_BRAILLE
  CTX_TERM_QUARTER
>;

constant CtxTextAlign is export := guint32;
our enum CtxTextAlignEnum is export (
  CTX_TEXT_ALIGN_START     => 0,
  'CTX_TEXT_ALIGN_END',
  'CTX_TEXT_ALIGN_CENTER',
  'CTX_TEXT_ALIGN_LEFT',
  'CTX_TEXT_ALIGN_RIGHT'
);

constant CtxTextBaseline is export := guint32;
our enum CtxTextBaselineEnum is export (
  CTX_TEXT_BASELINE_ALPHABETIC     => 0,
  'CTX_TEXT_BASELINE_TOP',
  'CTX_TEXT_BASELINE_HANGING',
  'CTX_TEXT_BASELINE_MIDDLE',
  'CTX_TEXT_BASELINE_IDEOGRAPHIC',
  'CTX_TEXT_BASELINE_BOTTOM'
);

constant CtxTextDirection is export := guint32;
our enum CtxTextDirectionEnum is export (
  CTX_TEXT_DIRECTION_INHERIT => 0,
  'CTX_TEXT_DIRECTION_LTR',
  'CTX_TEXT_DIRECTION_RTL'
);

constant CtxTransformation is export := guint32;
our enum CtxTransformationEnum is export (
  CTX_TRANSFORMATION_NONE         =>  0,
  CTX_TRANSFORMATION_SCREEN_SPACE =>  1,
  CTX_TRANSFORMATION_RELATIVE     =>  2,
  CTX_TRANSFORMATION_BITPACK      =>  4,
  CTX_TRANSFORMATION_STORE_CLEAR  => 16,
);

constant GeglAbyssPolicy is export := guint32;
our enum GeglAbyssPolicyEnum is export (
  GEGL_ABYSS_NONE             => 0,
  GEGL_ABYSS_CLAMP            => 1,
  GEGL_ABYSS_LOOP             => 2,
  GEGL_ABYSS_BLACK            => 3,
  GEGL_ABYSS_WHITE            => 4,

  GEGL_BUFFER_FILTER_AUTO     => 0,
  # auto gives bilinear for scales <1.0 box for <2.0 and nearest above #
  GEGL_BUFFER_FILTER_BILINEAR => 16,
  GEGL_BUFFER_FILTER_NEAREST  => 32,
  GEGL_BUFFER_FILTER_BOX      => 48,
  GEGL_BUFFER_FILTER_ALL      => 16 +| 32 +| 48 #= (GEGL_BUFFER_FILTER_BILINEAR | GEGL_BUFFER_FILTER_NEAREST| GEGL_BUFFER_FILTER_BOX),
);

constant GeglBlitFlags is export := guint32;
our enum GeglBlitFlagsEnum is export (
  GEGL_BLIT_DEFAULT =>      0,
  GEGL_BLIT_CACHE   => 1 +< 0,
  GEGL_BLIT_DIRTY   => 1 +< 1,
);

constant GeglCachePolicy is export := guint32;
our enum GeglCachePolicyEnum is export <
  GEGL_CACHE_POLICY_AUTO
  GEGL_CACHE_POLICY_NEVER
  GEGL_CACHE_POLICY_ALWAYS
>;

constant GeglClColorOp is export := guint32;
our enum GeglClColorOpEnum is export (
  GEGL_CL_COLOR_NOT_SUPPORTED => 0,
  GEGL_CL_COLOR_EQUAL         => 1,
  GEGL_CL_COLOR_CONVERT       => 2,
);

constant GeglCpuAccelFlags is export := guint32;
our enum GeglCpuAccelFlagsEnum is export (
  GEGL_CPU_ACCEL_NONE        =>        0x0,
  GEGL_CPU_ACCEL_X86_MMX     => 0x01000000,
  GEGL_CPU_ACCEL_X86_3DNOW   => 0x40000000,
  GEGL_CPU_ACCEL_X86_MMXEXT  => 0x20000000,
  GEGL_CPU_ACCEL_X86_SSE     => 0x10000000,
  GEGL_CPU_ACCEL_X86_SSE2    => 0x08000000,
  GEGL_CPU_ACCEL_X86_SSE3    => 0x02000000,
  GEGL_CPU_ACCEL_PPC_ALTIVEC => 0x04000000,
);

constant GeglDebugFlag is export := guint32;
our enum GeglDebugFlagEnum is export (
  GEGL_DEBUG_PROCESS      =>  1 +< 0,
  GEGL_DEBUG_BUFFER_LOAD  =>  1 +< 1,
  GEGL_DEBUG_BUFFER_SAVE  =>  1 +< 2,
  GEGL_DEBUG_TILE_BACKEND =>  1 +< 3,
  GEGL_DEBUG_PROCESSOR    =>  1 +< 4,
  GEGL_DEBUG_CACHE        =>  1 +< 5,
  GEGL_DEBUG_MISC         =>  1 +< 6,
  GEGL_DEBUG_INVALIDATION =>  1 +< 7,
  GEGL_DEBUG_OPENCL       =>  1 +< 8,
  GEGL_DEBUG_BUFFER_ALLOC =>  1 +< 9,
  GEGL_DEBUG_LICENSE      => 1 +< 10,
);

constant GeglDistanceMetric is export := guint32;
our enum GeglDistanceMetricEnum is export <
  GEGL_DISTANCE_METRIC_EUCLIDEAN
  GEGL_DISTANCE_METRIC_MANHATTAN
  GEGL_DISTANCE_METRIC_CHEBYSHEV
>;

constant GeglDitherMethod is export := guint32;
our enum GeglDitherMethodEnum is export <
  GEGL_DITHER_NONE
  GEGL_DITHER_FLOYD_STEINBERG
  GEGL_DITHER_BAYER
  GEGL_DITHER_RANDOM
  GEGL_DITHER_RANDOM_COVARIANT
  GEGL_DITHER_ARITHMETIC_ADD
  GEGL_DITHER_ARITHMETIC_ADD_COVARIANT
  GEGL_DITHER_ARITHMETIC_XOR
  GEGL_DITHER_ARITHMETIC_XOR_COVARIANT
  GEGL_DITHER_BLUE_NOISE
  GEGL_DITHER_BLUE_NOISE_COVARIANT
>;

constant GeglMapFlags is export := guint32;
our enum GeglMapFlagsEnum is export (
  GEGL_MAP_EXCLUDE_UNMAPPED => 1,
);

constant GeglOrientation is export := guint32;
our enum GeglOrientationEnum is export <
  GEGL_ORIENTATION_HORIZONTAL
  GEGL_ORIENTATION_VERTICAL
>;

constant GeglRectangleAlignment is export := guint32;
our enum GeglRectangleAlignmentEnum is export <
  GEGL_RECTANGLE_ALIGNMENT_SUBSET
  GEGL_RECTANGLE_ALIGNMENT_SUPERSET
  GEGL_RECTANGLE_ALIGNMENT_NEAREST
>;

constant GeglResolutionUnit is export := guint32;
our enum GeglResolutionUnitEnum is export <
  GEGL_RESOLUTION_UNIT_NONE
  GEGL_RESOLUTION_UNIT_DPI
  GEGL_RESOLUTION_UNIT_DPM
>;

constant GeglSamplerType is export := guint32;
our enum GeglSamplerTypeEnum is export <
  GEGL_SAMPLER_NEAREST
  GEGL_SAMPLER_LINEAR
  GEGL_SAMPLER_CUBIC
  GEGL_SAMPLER_NOHALO
  GEGL_SAMPLER_LOHALO
>;

constant GeglScCreationError is export := guint32;
our enum GeglScCreationErrorEnum is export (
  GEGL_SC_CREATION_ERROR_NONE              => 0,
  'GEGL_SC_CREATION_ERROR_EMPTY',
  'GEGL_SC_CREATION_ERROR_TOO_SMALL',
  'GEGL_SC_CREATION_ERROR_HOLED_OR_SPLIT'
);

constant GeglScDirection is export := guint32;
our enum GeglScDirectionEnum is export (
  GEGL_SC_DIRECTION_N     => 0,
  GEGL_SC_DIRECTION_NE    => 1,
  GEGL_SC_DIRECTION_E     => 2,
  GEGL_SC_DIRECTION_SE    => 3,
  GEGL_SC_DIRECTION_S     => 4,
  GEGL_SC_DIRECTION_SW    => 5,
  GEGL_SC_DIRECTION_W     => 6,
  GEGL_SC_DIRECTION_NW    => 7,
  GEGL_SC_DIRECTION_COUNT => 8,
);

constant GeglSerializeFlag is export := guint32;
our enum GeglSerializeFlagEnum is export (
  GEGL_SERIALIZE_TRIM_DEFAULTS => (1+<0),
  GEGL_SERIALIZE_VERSION       => (1+<1),
  GEGL_SERIALIZE_INDENT        => (1+<2),
  GEGL_SERIALIZE_BAKE_ANIM     => (1+<3),
);

constant GeglSplitStrategy is export := guint32;
our enum GeglSplitStrategyEnum is export <
  GEGL_SPLIT_STRATEGY_AUTO
  GEGL_SPLIT_STRATEGY_HORIZONTAL
  GEGL_SPLIT_STRATEGY_VERTICAL
>;

constant GeglTileCommand is export := guint32;
our enum GeglTileCommandEnum is export (
  GEGL_TILE_IDLE                   => 0,
  'GEGL_TILE_SET',
  'GEGL_TILE_GET',
  'GEGL_TILE_IS_CACHED',
  'GEGL_TILE_EXIST',
  'GEGL_TILE_VOID',
  'GEGL_TILE_FLUSH',
  'GEGL_TILE_REFETCH',
  'GEGL_TILE_REINIT',
  '_GEGL_TILE_LAST_0_4_8_COMMAND',
  GEGL_TILE_COPY                   => 9, # _GEGL_TILE_LAST_0_4_8_COMMAND,
  'GEGL_TILE_LAST_COMMAND'
);

constant NPDSettings is export := guint32;
our enum NPDSettingsEnum is export (
  NPD_BILINEAR_INTERPOLATION =>      1,
  NPD_ALPHA_BLENDING         => 1 +< 1,
);

constant VtMouseEvent is export := guint32;
our enum VtMouseEventEnum is export (
  VT_MOUSE_MOTION    => 0,
  'VT_MOUSE_PRESS',
  'VT_MOUSE_DRAG',
  'VT_MOUSE_RELEASE'
);
