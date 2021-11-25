use v6.c;

use Method::Also;

use NativeCall;

use GEGL::Raw::Types;
use GEGL::Raw::Init;

use GLib::Value;

use GLib::Roles::StaticClass;

class GEGL {
  also does GLib::Roles::StaticClass;

  method config ( :$raw = False ) {
    state $c = gegl_config();

    propReturnObject($c, $raw, |GLib::Object.getTypePair);
  }

  method exit {
    gegl_exit();
  }

  method get_option_group is also<get-option-group> {
    gegl_get_option_group();
  }

  multi method init ( *%options ) {
    (my $av = CArray[CArray[Str]].new)[0] = CArray[Str];
    my gint $ac = 0;

    samewith($ac, $av);

    self.config.set_property( .key, gv_str(.value) ) for %options.pairs
  }
  multi method init ($argc is rw, CArray[CArray[Str]] $argv) {
    gegl_init($argc, $argv);
  }

  method is_main_thread is also<is-main-thread> {
    so gegl_is_main_thread();
  }

  method load_module_directory (Str() $path) is also<load-module-directory> {
    gegl_load_module_directory($path);
  }

  method reset_stats is also<reset-stats> {
    gegl_reset_stats();
  }

  method stats {
    gegl_stats();
  }

  method get_cpu_accel_support
    is also<
      get-cpu-accel-support
      cpu_accel_get_support
      cpu-accel-get-support
    > {
    GeglCpuAccelFlagsEnum( gegl_cpu_accel_get_support() );
  }

}
