use v6.c;

use NativeCall;

use GEGL::Raw::Types;

use GLib::Roles::Signals::Generic;

role GEGL::Roles::Signals::Node {
  also does GLib::Roles::Signals::Generic;

  has %!signals-gn;

  # GeglNode, GeglRectangle, gpointer
  method connect-rectangle (
    $obj,
    $signal,
    &handler?
  ) {
    my $hid;
    %!signals-gn{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-rectangle($obj, $signal,
        -> $, $r, $ud {
          CATCH {
            default { 𝒮.note($_) }
          }

          𝒮.emit( [self, $r, $ud ] );
        },
        Pointer, 0
      );
      [ 𝒮.Supply, $obj, $hid ];
    };
    %!signals-gn{$signal}[0].tap(&handler) with &handler;
    %!signals-gn{$signal}[0];
  }

}

# GeglNode, GeglRectangle, gpointer
sub g-connect-rectangle (
  Pointer $app,
  Str $name,
  &handler (GeglNode, GeglRectangle, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }
