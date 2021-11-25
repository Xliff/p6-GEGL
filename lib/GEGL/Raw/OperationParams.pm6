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
      shiftx     => 'double',
      shifty     => 'double',
      zoom       => 'double',
      iterations => 'int64',
      cx         => 'double',
      cy         => 'double'
    }
  );

}
