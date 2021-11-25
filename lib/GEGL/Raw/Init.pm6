use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GEGL::Raw::Definitions;
use GEGL::Raw::Enums;

unit package GEGL::Raw::Init;

### /usr/include/gegl-0.4/gegl-init.h

sub gegl_config ()
  returns GeglConfig
  is native(gegl)
  is export
{ * }

sub gegl_exit ()
  is native(gegl)
  is export
{ * }

sub gegl_get_option_group ()
  returns GOptionGroup
  is native(gegl)
  is export
{ * }

sub gegl_init (gint $argc is rw, CArray[CArray[Str]] $argv)
  is native(gegl)
  is export
{ * }

sub gegl_is_main_thread ()
  returns uint32
  is native(gegl)
  is export
{ * }

sub gegl_load_module_directory (Str $path)
  is native(gegl)
  is export
{ * }

sub gegl_reset_stats ()
  is native(gegl)
  is export
{ * }

sub gegl_stats ()
  returns GeglStats
  is native(gegl)
  is export
{ * }

### /usr/include/gegl-0.4/gegl-cpuaccel.h

sub gegl_cpu_accel_get_support
  returns GeglCpuAccelFlags
  is native(gegl)
  is export
{ * }
