use v6.c;

use GLib::Raw::Enums;
use GEGL::Color;

our %operations is export;

INIT {
  %operations = (
    display => {
      width  => 'float',
      height => 'float'
    },

    over => { },

    text => {
      size   => 'float',
      color  => Pair.new('object', ::('GEGL::Color').get_type),
      string => 'string'
    },

    crop => {
      width  => 'float',
      height => 'float'
    },

    fractal-explorer => {
      fractaltype  => [
        'string',
        <
          mandelbrot
          julia
          barnsley-1
          barnsley-2
          barnsley-3
          spider
          man-o-war
          sierpinski
        >
      ],
      shiftx       => 'double',
      shifty       => 'double',
      zoom         => 'double',
      iter         => 'uint',
      cx           => 'double',
      cy           => 'double',
      redstretch   => 'double',
      greenstretch => 'double',
      bluestretch  => 'double',
      redmode      => [
        'string',
        <sine cosine none>
      ],
      greenmode    => [
        'string',
        <sine cosine none>
      ],
      bluemode     => [
        'string',
        <sine cosine none>
      ],
      redinvert    => 'boolean',
      greeninvert  => 'boolean',
      blueinvert   => 'boolean',
      useloglog    => 'boolean',
      ncolors      => 'uint'
    }
  );

}

CHECK {
  for %operations.kv {
    say "Checking operation { .key }...";
    for .value.pairs {
      say "\tParam { .key }...";
      die "'{ .value }' is not a valid type!" unless
        .value eq %strToGType.keys.any;
      if .value ~~ Array {
        die "Array paramspec must have 2 elements!";
      }
    }
  }
}
