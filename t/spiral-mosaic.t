use v6.d;

use GEGL::Raw::Types;

use GEGL;
use GEGL::Color;
use GEGL::Node;

constant FRAMES = 2000;

# cw: This isn't working, so its quite possible op:fractal-explorer
#     is quietly failing as a result!
GEGL.init( application-license => 'GPL3' );

my $tv   = GEGL::Color.get_type;
my $t    = GLib::Object::Type.new($tv);
my $gegl = GEGL::Node.new;

my $display = $gegl.create-child('gegl:display');

my $crop    = $gegl.new-child(
  operation => 'gegl:crop',
  width     => 800,
  height    => 600
);

my $cv = GLib::Value.new( GEGL::Color.get_type );
my $color = $cv.object = GEGL::Color.new('rgb(0.1,0.3,0.8)');

my $spiral  = $gegl.new-child(
  operation => 'gegl:spiral',
  color1    => $cv
);

# my $gcv = GLib::Value.new( GEGL::Color.get_type );
#my $grid-color = $gcv.object = GEGL::Color.new("rgb(0.0, 0.2, 0.5)");

# my $grid    = $gegl.new_child(
#   operation   => 'gegl:grid',
#   x           => 8,
#   y           => 8,
#   line-width  => 8,
# #  line-color  => $gcv
# );

# my $alpha = $gegl.new_child(
#   operation => 'gegl:color-to-alpha'
# );

my $mosaic = $gegl.new_child(
  operation => 'gegl:mosaic'
);

# my $over    = $gegl.new-child(
#   operation => 'gegl:over'
# );

$spiral.link-many($mosaic, $crop, $display);
# $alpha.connect-to('output', $over, 'aux');
# $spiral.connect-to('output', $alpha, 'input');

sub interpolate ($t, $min, $max, $modulus = $max) {
  my $v = $max * $t + $min * (1.0 - $t);
  if $modulus < $max {
    $v -= $modulus * ($v / $modulus).Int;
  }
  $v;
}

for ^FRAMES {
  my $t = $_ * 1/FRAMES;

  # $gcv = GLib::Value.new( GEGL::Color.get_type );
  # $grid-color = $gcv.object = GEGL::Color.new(
  #   "rgb({ $t.&interpolate(0, 4, 1).fmt('%.2f') }, 0.2, 0.5)"
  # );

  # $grid.set(
  #   x          => $t.&interpolate(8, 64),
  #   y          => $t.&interpolate(8, 64),
  #   # line-color => $gcv
  # );

  $spiral.set(
    rotation => $t.&interpolate(0,360 * 15, 360)
  );

  $display.process
}
