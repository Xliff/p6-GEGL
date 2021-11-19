use v6.c;

unit package GEGL::Raw::Exports;

our @gegl-exports is export;

BEGIN {
  @gegl-exports = <
    GEGL::Raw::Definitions
    GEGL::Raw::Enums
    GEGL::Raw::Structs
  >;
}
