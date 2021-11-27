use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GDK::Raw::Structs;
use GLib::Roles::Pointers;

unit package GEGL::Raw::Definitions;

constant gegl is export = 'gegl-0.4',v0;

# Compat
class Babl                    is repr<CPointer> does GLib::Roles::Pointers is export { }

class GeglBuffer              is repr<CPointer> does GLib::Roles::Pointers is export { }
class GeglColor               is repr<CPointer> does GLib::Roles::Pointers is export { }
class GeglConfig              is repr<CPointer> does GLib::Roles::Pointers is export { }
class GeglNode                is repr<CPointer> does GLib::Roles::Pointers is export { }
class GeglNodeOutputVisitable is repr<CPointer> does GLib::Roles::Pointers is export { }
class GeglStats               is repr<CPointer> does GLib::Roles::Pointers is export { }
class GeglParamSpecUri        is repr<CPointer> does GLib::Roles::Pointers is export { }
class GeglTile                is repr<CPointer> does GLib::Roles::Pointers is export { }
class GeglTileSourceCommand   is repr<CPointer> does GLib::Roles::Pointers is export { }
class GeglProcessor           is repr<CPointer> does GLib::Roles::Pointers is export { }
class GeglMetadata            is repr<CPointer> does GLib::Roles::Pointers is export { }
class GeglMetadataStore       is repr<CPointer> does GLib::Roles::Pointers is export { }
class GeglMetadataHash        is repr<CPointer> does GLib::Roles::Pointers is export { }

class GeglOperation           is repr<CPointer> does GLib::Roles::Pointers is export { }
class GeglSampler             is repr<CPointer> does GLib::Roles::Pointers is export { }

# Interface
class GeglVisitable           is repr<CPointer> does GLib::Roles::Pointers is export { }

constant GeglRectangle is export := GdkRectangle;

class X::GEGL::Node::NoOperationResolution is Exception is export {
  has $!op   is built;
  has $!name is built;
  has $!type is built;

  submethod BUILD ( :$!op, :$!name, :$!type ) { }

  method new ($op, $name, $type) {
    self.bless( :$op, :$name, :$type );
  }

  method message {
    "Parameter { $!name } for operation { $!op } cannot tape a value of type {
      $!type }";
  }
}
