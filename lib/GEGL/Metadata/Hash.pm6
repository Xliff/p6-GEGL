use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GEGL::Raw::Types;

use GEGL::Metadata::Store;

our subset GeglMetadataHashAncestry is export of Mu
  where GeglMetadataHash | GeglMetadataStoreAncestry;

class GEGL::Metadata::Hash is GEGL::Metadata::Store {
  has GeglMetadataHash $!gmh is implementor;

  submethod BUILD ( :$gegl-hash ) {
    self.setGeglMetadataHash($gegl-hash) if $gegl-hash;
  }

  method setGeglMetadataHash (GeglMetadataHashAncestry $_) {
    my $to-parent;

    $!gmh = do {
      when GeglMetadataHash {
        $to-parent = cast(GeglMetadataStore, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GeglMetadataHash, $_);
      }
    }
    self.setGeglMetadataStore($to-parent);
  }

  method GEGL::Raw::Definitions::GeglMetadataHash
    is also<GeglMetadataHash>
  { $!gmh }

  multi method new (
    GeglMetadataHashAncestry $gegl-hash,
                             :$ref       = True
  ) {
    return Nil unless $gegl-hash;

    my $o = self.bless( :$gegl-hash );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $gegl-hash = gegl_metadata_hash_new();

    $gegl-hash ?? self.bless( :$gegl-hash ) !! Nil;
  }

}


### /usr/include/gegl-0.4/gegl-metadatahash.h

sub gegl_metadata_hash_new ()
  returns GeglMetadataHash
  is native(gegl)
  is export
{ * }
