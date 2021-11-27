use v6.c;

use Method::Also;

use GEGL::Raw::Types;
use GEGL::Raw::Metadata::Store;

use GLib::Roles::Object;
use GEGL::Roles::Metadata;
use GEGL::Roles::Signals::Metadata::Store;

use GLib::Roles;

our subset GeglMetadataStoreAncestry is export of Mu
  where GeglMetadataStore | GeglMetadata | GObject;

class GEGL::Metadata::Store {
  also does Associative;
  also does GLib::Roles::Object;
  also does GEGL::Roles::Metadata;
  also does GEGL::Roles::Signals::Metadata::Store;

  has GeglMetadataStore $!gms is implementor;

  submethod BUILD ( :$gegl-metadata-store ) {
    self.setGeglMetadataStore($gegl-metadata-store) if $gegl-metadata-store;
  }

  method setGeglMetadataStore (GeglMetadataStoreAncestry $_) {
    my $to-parent;

    $!gms = do {
      when GeglMetadataStore {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GeglMetadataStore, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GEGL::Raw::Definitions::GeglMetadataStore
    is also<GeglMetadataStore>
  { $!gms }

  multi method new (
    GeglMetadataStoreAncestry $gegl-metadata-store,
                              :$ref                = True
  ) {
    return Nil unless $gegl-metadata-store;

    my $o = self.bless(:$gegl-metadata-store);
    $o.ref if $ref;
    $o;
  }

  method !standard-keys {
    state @standard-keys = self.^methods.grep( * ~~ GProperty ).map( *.name );
    @standard-keys;
  }

  method EXISTS-KEY (\k) {
    return True if k eq self!standard-keys.any;
    self.has-value(k);
  }

  method AT-KEY (\k) is rw {
    return self."{ k }"() if k eq self!standard-keys.any;

    Proxy.new:
      FETCH => -> $     { self.get_value(k).value },

      STORE => -> $, \v {
        my $val = GLib::Value.new( self.typeof-value(k) );
        $val.value = v;
        self.set_value(k, $val);
      };
  }

  method artist is rw is g-property {
    Proxy.new:
      FETCH => -> $     { self.get_artist    },
      STORE => -> $, \v { self.set_artist(v) }
  }

  method comment is rw is g-property {
    Proxy.new:
      FETCH => -> $     { self.get_comment    },
      STORE => -> $, \v { self.set_comment(v) }
  }

  method copyright is rw is g-property {
    Proxy.new:
      FETCH => -> $     { self.get_copyright    },
      STORE => -> $, \v { self.set_copyright(v) }
  }

  method description is rw is g-property {
    Proxy.new:
      FETCH => -> $     { self.get_description    },
      STORE => -> $, \v { self.set_description(v) }
  }

  method disclaimer is rw is g-property {
    Proxy.new:
      FETCH => -> $     { self.get_disclaimer    },
      STORE => -> $, \v { self.set_disclaimer(v) }
  }

  method resolution_unit is rw is g-property is also<resolution-unit> {
    Proxy.new:
      FETCH => -> $     { self.get_resolution_unit    },
      STORE => -> $, \v { self.set_resolution_unit(v) }
  }

  method resolution_x is rw is g-property is also<resolution-x> {
    Proxy.new:
      FETCH => -> $     { self.get_resolution_x    },
      STORE => -> $, \v { self.set_resolution_x(v) }
  }

  method resolution_y is rw is g-property is also<resolution-y> {
    Proxy.new:
      FETCH => -> $     { self.get_resolution_y    },
      STORE => -> $, \v { self.set_resolution_y(v) }
  }

  method software is rw is g-property {
    Proxy.new:
      FETCH => -> $     { self.get_software    },
      STORE => -> $, \v { self.set_software(v) }
  }

  method source is rw is g-property {
    Proxy.new:
      FETCH => -> $     { self.get_source    },
      STORE => -> $, \v { self.set_source(v) }
  }

  method string is rw is g-property {
    Proxy.new:
      FETCH => -> $     { self.get_string    },
      STORE => -> $, \v { self.set_string(v) }
  }

  method timestamp is rw is g-property {
    Proxy.new:
      FETCH => -> $     { self.get_timestamp    },
      STORE => -> $, \v { self.set_timestamp(v) }
  }

  method title is rw is g-property {
    Proxy.new:
      FETCH => -> $     { self.get_title    },
      STORE => -> $, \v { self.set_title(v) }
  }

  method warning is rw is g-property {
    Proxy.new:
      FETCH => -> $     { self.get_warning    },
      STORE => -> $, \v { self.set_warning(v) }
  }

  # changed
  # GeglMetadataStore, GParamspec, gpointer
  method changed {
    self.connect-paramspec($!gms, 'changed');
  }

  # mapped
  # GeglMetadataStore, Str, gboolean, gpointer
  method mapped {
    self.connect-str-bool($!gms, 'mapped');
  }

  # unmapped
  # GeglMetadataStore, Str, Str, gpointer
  method unmapped {
    self.connect-strstr($!gms, 'unmapped');
  }

  # generate-value
  # GeglMetadataStore, GParamspec, GValue (inout), gpointer --> gboolean
  method generate-value is also<generate_value> {
    self.connect-paramspec-value($!gms, 'generate-value');
  }

  # parse-value
  # GeglMetadataStore, GGParamspec, GValue (inout), gpointer --> gboolean
  method parse-value is also<parse_value> {
    self.connect-paramspec-value($!gms, 'parse-value');
  }

  method declare (GParamSpec() $pspec) {
    gegl_metadata_store_declare($!gms, $pspec);
  }

  # method gegl_resolution_unit_get_type {
  #   gegl_resolution_unit_get_type();
  # }

  method get_artist is also<get-artist> {
    gegl_metadata_store_get_artist($!gms);
  }

  method get_comment is also<get-comment> {
    gegl_metadata_store_get_comment($!gms);
  }

  method get_copyright is also<get-copyright> {
    gegl_metadata_store_get_copyright($!gms);
  }

  method get_description is also<get-description> {
    gegl_metadata_store_get_description($!gms);
  }

  method get_disclaimer is also<get-disclaimer> {
    gegl_metadata_store_get_disclaimer($!gms);
  }

  method get_file_module_name is also<get-file-module-name> {
    gegl_metadata_store_get_file_module_name($!gms);
  }

  method get_resolution_unit is also<get-resolution-unit> {
    GeglResolutionUnit( gegl_metadata_store_get_resolution_unit($!gms) )
  }

  method get_resolution_x is also<get-resolution-x> {
    gegl_metadata_store_get_resolution_x($!gms);
  }

  method get_resolution_y is also<get-resolution-y> {
    gegl_metadata_store_get_resolution_y($!gms);
  }

  method get_software is also<get-software> {
    gegl_metadata_store_get_software($!gms);
  }

  method get_source is also<get-source> {
    gegl_metadata_store_get_source($!gms);
  }

  method get_string (Str() $name) is also<get-string> {
    gegl_metadata_store_get_string($!gms, $name);
  }

  method get_timestamp ( :$raw = False ) is also<get-timestamp> {
    propReturnObject(
      gegl_metadata_store_get_timestamp($!gms),
      $raw,
      |GLib::DateTime.getTypePair
    );
  }

  method get_title is also<get-title> {
    gegl_metadata_store_get_title($!gms);
  }

  method get_value (Str() $name, GValue() $value) is also<get-value> {
    gegl_metadata_store_get_value($!gms, $name, $value);
  }

  method get_warning is also<get-warning> {
    gegl_metadata_store_get_warning($!gms);
  }

  method has_value (Str() $name) is also<has-value> {
    gegl_metadata_store_has_value($!gms, $name);
  }

  method notify (GParamSpec() $pspec, Int() $shadow) {
    my gboolean $s = $shadow.so.Int;

    gegl_metadata_store_notify($!gms, $pspec, $s);
  }

  method register (Str() $local_name, Str() $name, &transform) {
    gegl_metadata_store_register($!gms, $local_name, $name, &transform);
  }

  method set_artist (Str() $artist) is also<set-artist> {
    gegl_metadata_store_set_artist($!gms, $artist);
  }

  method set_comment (Str() $comment) is also<set-comment> {
    gegl_metadata_store_set_comment($!gms, $comment);
  }

  method set_copyright (Str() $copyright) is also<set-copyright> {
    gegl_metadata_store_set_copyright($!gms, $copyright);
  }

  method set_description (Str() $description) is also<set-description> {
    gegl_metadata_store_set_description($!gms, $description);
  }

  method set_disclaimer (Str() $disclaimer) is also<set-disclaimer> {
    gegl_metadata_store_set_disclaimer($!gms, $disclaimer);
  }

  method set_resolution_unit (Int() $unit) is also<set-resolution-unit> {
    my GeglResolutionUnit $u = $unit;

    gegl_metadata_store_set_resolution_unit($!gms, $u);
  }

  method set_resolution_x (Num() $resolution_x) is also<set-resolution-x> {
    my gdouble $r = $resolution_x;

    gegl_metadata_store_set_resolution_x($!gms, $r);
  }

  method set_resolution_y (Num() $resolution_y) is also<set-resolution-y> {
    my gdouble $r = $resolution_y;

    gegl_metadata_store_set_resolution_y($!gms, $r);
  }

  method set_software (Str() $software) is also<set-software> {
    gegl_metadata_store_set_software($!gms, $software);
  }

  method set_source (Str() $source) is also<set-source> {
    gegl_metadata_store_set_source($!gms, $source);
  }

  method set_string (Str() $name, Str() $string) is also<set-string> {
    gegl_metadata_store_set_string($!gms, $name, $string);
  }

  method set_timestamp (GDateTime() $timestamp) is also<set-timestamp> {
    gegl_metadata_store_set_timestamp($!gms, $timestamp);
  }

  method set_title (Str() $title) is also<set-title> {
    gegl_metadata_store_set_title($!gms, $title);
  }

  method set_value (Str() $name, GValue() $value) is also<set-value> {
    gegl_metadata_store_set_value($!gms, $name, $value);
  }

  method set_warning (Str() $warning) is also<set-warning> {
    gegl_metadata_store_set_warning($!gms, $warning);
  }

  method typeof_value (Str() $name) is also<typeof-value> {
    gegl_metadata_store_typeof_value($!gms, $name);
  }

}
