# Zig build for LibYAML

This project builds [LibYAML](https://github.com/yaml/libyaml) with the Zig build system. No
dependencies are required except for Zig.

To build a static library, run:

```
zig build
```

To run tests, run:

```
zig build test
```

Commits from https://github.com/yaml/libyaml/pull/250 are included to fix compiling with musl.

The original README contents are included below:

---

## LibYAML - A C library for parsing and emitting YAML.

To build and install the library, run:

    $ ./configure
    $ make
    # make install

Required packages:

- gcc
- libtool
- make

If you checked the source code from the Git repository, run

    $ ./bootstrap
    $ ./configure
    $ make
    # make install

Required packages:

- autoconf
- libtool
- make

For more information, check the [LibYAML
homepage](https://github.com/yaml/libyaml).

Discuss LibYAML with the maintainers in IRC #libyaml irc.freenode.net.

You may also use the [YAML-Core mailing
list](http://lists.sourceforge.net/lists/listinfo/yaml-core).

Submit bug reports and feature requests to the [LibYAML bug
tracker](https://github.com/yaml/libyaml/issues/new).

This project was developed for Python Software Foundation as a part of Google
Summer of Code under the mentorship of Clark Evans.

The LibYAML module was written by Kirill Simonov <xi@resolvent.net>.
It is currently maintained by the YAML community.

LibYAML is released under the MIT license.
See the file LICENSE for more details.
