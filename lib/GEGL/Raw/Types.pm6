use v6.c;

use NativeCall;

use GLib::Raw::Exports;
use GEGL::Raw::Exports;

my constant forced = 188;

unit package GEGL::Raw::Types;

need GLib::Raw::Debug;
need GLib::Raw::Definitions;
need GLib::Raw::Enums;
need GLib::Raw::Exceptions;
need GLib::Raw::Object;
need GLib::Raw::Structs;
need GLib::Raw::Struct_Subs;
need GLib::Raw::Subs;
need GLib::Roles::Pointers;
need GLib::Roles::Implementor;
need BABL;
need GEGL::Raw::Definitions;
need GEGL::Raw::Enums;
need GEGL::Raw::Structs;

BEGIN {
  glib-re-export($_) for |@glib-exports,
                         'BABL',
                         |@gegl-exports;
}