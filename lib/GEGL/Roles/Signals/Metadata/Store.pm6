use v6.c;

use NativeCall;

use GLib::Raw::ReturnedValue;

use GEGL::Raw::Types;

use GLib::Roles::Signals::Generic;

role GEGL::Roles::Signals::Metadata::Store {
  also does GLib::Roles::Signals::Generic;

  has %!signals-gms;

  # GeglMetadataStore, GParamspec, GValue (inout), gpointer --> gboolean
  method connect-paramspec-value (
    $obj,
    $signal,
    &handler?
  ) {
    my $hid;
    %!signals-gms{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-paramspec-value($obj, $signal,
        -> $, $ps, $v, $ud {
          CATCH {
            default { 𝒮.note($_) }
          }

          my $r = ReturnedValue.new;
          𝒮.emit( [self, $ps, $v, $ud, $r ] );
          $r.r
        },
        Pointer, 0
      );
      [ 𝒮.Supply, $obj, $hid ];
    };
    %!signals-gms{$signal}[0].tap(&handler) with &handler;
    %!signals-gms{$signal}[0];
  }

}

# changed
# GeglMetadataStore, GParamspec, gpointer

# mapped
# GeglMetadataStore, Str, gboolean, gpointer

# unmapped
# GeglMetadataStore, Str, Str, gpointer

# GeglMetadataStore, GParamspec, GValue (inout), gpointer --> gboolean
sub g-connect-paramspec-value (
  Pointer $app,
  Str $name,
  &handler (GeglMetadataStore, GParamSpec, GValue, gpointer --> gboolean),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }
