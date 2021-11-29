#!/usr/bin/env raku
use File::Find;
use GEGL::Raw::Enums;

grammar EnumGrammar {
  rule TOP {
    'enum_start'\s*'(' <enum-type-sub> ")\n"

    <enum-value>+

    'enum_end (' <enum-type> ')'
  }

  rule enum-value {
    'enum_value'\s*'('<enum-key>\s*','"\n"? <val>",""\n"?\s*'N_('<name=quoted-value>'))'
    ||
    'enum_value_skip (' .+? ')'
  }

  token quoted-value  { '"' ~ '"' (<[\(\)_\w\s°\'/-]>+)  }
  token enum-key      { <capital-word>+ % '_'            }
  token capital-word  { <[A..Z0..9a..z]>+                }
  token enum-type-sub { \w+                              }
  token enum-type     { \w+                              }
  token val           { <quoted-value>                   }
}

sub MAIN ($dir) {

  # Grab enum properties
  my rule enum-property {
    'property_enum ('
      (\w+)','
      '_('
        '"' ~ '"' <[\w\s-]>+
      "),\n"
    \s* (\w+)
  }


  say qq:to/OUT/;
  use v6.c;

  use GLib::Raw::Enums;

  use GEGL::Buffer;
  use GEGL::Color;

  use GEGL::Roles::Metadata;

  our %operations is export;

  INIT \{
    \%operations = (
  OUT

  my @entries;
  for find(
    :$dir,
    name => / '.c' $ /
  ).sort( *.basename ) -> $file {
    #say "Processing { $file } ...";
    my (%enums, $em);

    my $op = $file.slurp;
    $op ~~ s:g/'description(_(' .+? '))'//;

    my $enums = $op ~~ m:g/'enum_start' .+? 'enum_end (' \w+ ')'/;

    if $enums {

      for $enums[] {
        my $enum-def = .Str;
        $enum-def ~~ s:g/ '/*' ~ '*/' .+?//;
        $enum-def ~~ s:g/^^'#' .+? "\n"//;
        $enum-def ~~ s:g/^^\s*'//' .+? "\n"//;

        my $eg = EnumGrammar.parse($enum-def);

        unless $eg {
          say "Not parsed: { $enum-def }";
        }

        my @words;
        with $eg {
          my $et = $eg<enum-type>.Str;
          %enums{$et} = $eg<enum-value>.map( *<val><quoted-value>[0].Str )
                                       .Array;
        }
      }

      $em = $op ~~ m:g/ <enum-property> /;
    }

    # cw: Grab all properties BUT enums
    my $m = $op ~~ m:g/ "property_"(\w+)<?{ .[0] ne 'enum' }>\s*'('(\w+)/;
    my @p;
    with $m {
      for $m[] {
        my $n = .[1].Str;
        my $t = do given .[0].Str {
          when 'object' {
            do given $n {
              when 'buffer' {
                q«Pair.new('object', GEGL::Buffer.get_type)»
              }

              when 'metadata' {
                q«Pair.new('object', GEGL::Metadata.get_type)»
              }
            }
          }

          when 'color'  {
            q«Pair.new('object', GEGL::Color.get_type)»
          }

          when 'file_path' {
            q«'string'»
          }

          default {
            qq«'{ .[0].Str }'»
          }
        }

        @p.push: "{ .[1].Str } => { $t }" unless $t eq 'enum';
      }
    }
    if $em {
      for $em[] {
        my $value-type = 'string';
        my $values = %enums{ .<enum-property>[1] };

        my ($op, $cl) = ('<', '>');
        if $values.defined {
          $values .= join("\n            ");
        } else {
          my $s = .<enum-property>[1];
          my $iet  = try ::("{ $s }Enum");


          if $iet ~~ Failure || $iet === Nil || $iet === Any {
            %enums.gist.say;
            die "Can't find enum symbol '{ $s }' in { $file.absolute }"
          }

          $value-type = 'uint';
          $values = $iet.enums.values.unique.sort.join(
            ($value-type eq 'uint' ?? ',' !! '') ~
            "\n            "
          );
          ($op, $cl) = «( )» if $value-type eq 'uint';
        }

        my $name = .<enum-property>[0];
        $name = "'{ $name }'" if $name.contains('-');
        @p.push: qq:to/DEF/.chomp;
        { $name } => [
                  '{ $value-type }',
                  { $op }
                    { $values }
                  { $cl }
                ]
        DEF
      }
    }

    my $file-key = $file.IO.basename.subst(".c", "");
    $file-key = "'{ $file-key }'" if $file-key.contains('-');
    @entries.push: "    { $file-key } => \{ \n        {
          @p.join(",\n        ") }\n    \}" if @p;
  }

  say "{ @entries.join(",\n") }\n  );\n}"

}
