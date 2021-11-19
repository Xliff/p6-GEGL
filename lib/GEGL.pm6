use v6.c;

use NativeCall;

use GEGL::Raw::Types;
use GEGL::Raw::Init;

use GLib::Roles::StaticClass;

class GEGL {
  also does GLib::Roles::StaticClass;

  method config ( :$raw = False ) {
    my $c = gegl_config();
    return $c if $raw;
    GLib::Object.new( cast(GObject, $c) );
  }

  method exit {
    gegl_exit();
  }

  method get_option_group {
    gegl_get_option_group();
  }

  multi method init ( :%options ) {
    (my $av = CArray[CArray[Str]].new)[0] = CArray[Str];
    my gint $ac = 0;

    samewith($ac, $av);

    my $c = ::?CLASS.config;
    $c.prop_set_string(.key, .value) for %options.pairs;
  }
  multi method init ($argc is rw, CArray[CArray[Str]] $argv) {
    gegl_init($argc, $argv);
  }

  method is_main_thread {
    so gegl_is_main_thread();
  }

  method load_module_directory (Str() $path) {
    gegl_load_module_directory($path);
  }

  method reset_stats {
    gegl_reset_stats();
  }

  method stats {
    gegl_stats();
  }

}
