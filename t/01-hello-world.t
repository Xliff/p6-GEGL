use v6.d;

use GEGL::Raw::Types;

use GLib::Object::Type;

use GEGL;
use GEGL::Color;
use GEGL::Node;

constant FRAMES = 200;

GEGL.init( application-license => 'GPL3' );

my $tv = GEGL::Color.get_type;
my $t  = GLib::Object::Type.new($tv);

say "Type name for value { $tv } is { $t.name }";

my $gegl    = GEGL::Node.new;

my $display = $gegl.create-child('gegl:display');

my $crop    = $gegl.new-child(
  operation => 'gegl:crop',
  width     => 512,
  height    => 384
);

my $over    = $gegl.new-child(
  operation => 'gegl:over'
);

my $cv = GLib::Value.new( GEGL::Color.get_type );
$cv.object = GEGL::Color.new('rgb(1.0,1.0,1.0)');

my $text    = $gegl.new-child(
  operation => 'gegl:text',
  size      => 10,
  color     => $cv
);

my $fractal = $gegl.new-child(
  operation => 'gegl:fractal-explorer',
  shiftx    => -256
);

$fractal.link-many($over, $crop, $display);
$text.connect-to('output', $over, 'aux');

sub f ($s) { $s.fmt('%1.3f') };

sub interpolate ($t, $min, $max) {
  $max * $t + $min * (1 - $t)
}

for ^FRAMES -> $t {
  my $shiftx = $t.&interpolate(-256, -512);
  my $shifty = $t.&interpolate(0,    -256);
  my $zoom   = $t.&interpolate(300,   400);

  $fractal.set( :$shiftx, :$shifty, :$zoom );

  $text.set( 'string' => "x={ $shiftx.&f } y={ $shifty.&f } z={ $zoom.&f }" );
  $display.process
}
