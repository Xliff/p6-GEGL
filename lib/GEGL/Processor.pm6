use v6.c;

use Method::Also;

use GLib::Raw::Types;

use GLib::Roles::Object;

our subset GeglProcessorAncestry is export of Mu
  where GeglProcessor | GObject;

class GEGL::Processor {
  also does GLib::Roles::Object;

  has GeglProcessor $!gp is implementor;

  submethod BUILD ( :$gegl-processor ) {
    self.setGeglProcesor($gegl-processor) if $gegl-processor;
  }

  method setGeglProcesor (GeglProcesorAncestry $_) {
    my $to-parent;

    $!gp = do {
      when GeglProcesor {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GeglProcesor, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GEGL::Raw::Definitions::GeglProcesor
    is also<GeglProcessor>
  { $!gp }

  multi method new (GeglProcesorAncestry $gegl-processor, :$ref = True) {
    return Nil unless $gegl-processor;

    my $o = self.bless(:$gegl-processor);
    $o.ref if $ref;
    $o;
  }

  method get_buffer ( :$raw = False ) is also<get-buffer> {
    propReturnObject(
      gegl_processor_get_buffer($!gp),
      $raw,
      |::('GEGL::Buffer').getTypePair
    )
  }

  method set_level (Int() $level) is also<set-level> {
    my gint $l = $level;

    gegl_processor_set_level($!gp, $l);
  }

  method set_rectangle (GeglRectangle() $rectangle) is also<set-rectangle> {
    gegl_processor_set_rectangle($!gp, $rectangle);
  }

  method set_scale (Num() $scale) is also<set-scale> {
    my double $s = $scale;

    gegl_processor_set_scale($!gp, $s);
  }

  multi method work {
    samewith($);
  }
  multi method work ($progress is rw) {
    my gdouble $p = 0;

    my $r = so gegl_processor_work($!gp, $p);
    $progress = $p;
    $r;
  }

}

### /usr/include/gegl-0.4/gegl-processor.h

sub gegl_processor_get_buffer (GeglProcessor $processor)
  returns GeglBuffer
  is native(gegl)
  is export
{ * }

sub gegl_processor_set_level (GeglProcessor $processor, gint $level)
  is native(gegl)
  is export
{ * }

sub gegl_processor_set_rectangle (
  GeglProcessor $processor,
  GeglRectangle $rectangle
)
  is native(gegl)
  is export
{ * }

sub gegl_processor_set_scale (GeglProcessor $processor, gdouble $scale)
  is native(gegl)
  is export
{ * }

sub gegl_processor_work (GeglProcessor $processor, gdouble $progress is rw)
  returns uint32
  is native(gegl)
  is export
{ * }
