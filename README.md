# p6-GEGL - GEGL bindings for Perl6

## Installation

Make a directory to contain the p6-GLib-based projects. Once made, then set the P6_GLIB_HOME environment variable to that directory:

```
$ export P6_GLIB_HOME=/path/to/projects
```

Switch to that directory and clone both p6-GtkPlus and p6-GEGL

```
$ git clone https://github.com/Xliff/p6-GLib.git
$ git clone https://github.com/Xliff/p6-GtkPlus.git
$ git clone https://github.com/Xliff/p6-GEGL.git
$ cd p6-GLib
$ zef install --deps-only .
```

[Optional] To build all of GEGL and the required GLib modules, you can then:

```
$ cd ../p6-GEGL
```

To quickly build things, try the parallel builder:

```
$ scripts/dependency-build.pl6
```

If that gives you problems, you can try the original builder:


```
$ ./build.sh
```

You should be set now! If you just want to run the examples, you can do:

```
$ ./p6gtkexec t/<name of example>
```

Otherwise you are now ready to play around.

Note: We know the compile times are annoying, but they are getting better. Pleas bear with us while the install process is further developed.
