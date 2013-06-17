# NAME

Text::Sass::XS - Perl Binding for libsass

# SYNOPSIS

    # OO Interface
    use Text::Sass::XS;

    my $sass = Text::Sass::XS->new;
    my $css = $sass->compile(".something { color: red; }");

    # OO Interface with options
    my $sass = Text::Sass::XS->new(
        include_paths   => ['path/to/include'],
        image_path      => 'base_url',
        output_style    => SASS_STYLE_COMPRESSED,
        source_comments => SASS_SOURCE_COMMENTS_NONE,
        dont_die        => 1,
    );
    my $css = $sass->compile(".something { color: red; }");
    unless ( defined $css ) {
        warn $sass->last_error;
    }



    # Compile from file.
    my $sass = Text::Sass::XS->new;
    my $css = $sass->compile_compile("/path/to/foo.scss");

    # with options.
    my $sass = Text::Sass::XS->new(
        include_paths   => ['path/to/include'],
        image_path      => 'base_url',
        output_style    => SASS_STYLE_COMPRESSED,
        source_comments => SASS_SOURCE_COMMENTS_NONE,
        dont_die        => 1,
    );
    my $css = $sass->compile_compile("/path/to/foo.scss");





    # Functional Interface
    # export sass_compile, sass_compile_file and some constants
    use Text::Sass::XS ':all';

    my $sass = "your sass string here...";
    my $options = {
        output_style    => SASS_STYLE_COMPRESSED,
        source_comments => SASS_SOURCE_COMMENTS_NONE,
        include_paths   => 'site/css:vendor/css',
        image_path      => '/images'
    };
    my ($css, $err) = sass_compile($sass, $options);
    die $err if $err;

    my $sass_filename = "/path/to/foo.scss";
    my $options = {
        output_style    => SASS_STYLE_COMPRESSED,
        source_comments => SASS_SOURCE_COMMENTS_NONE,
        include_paths   => 'site/css:vendor/css',
        image_path      => '/images'
    };

    # In scalar context, sass_compile(_file)? returns css only.
    my $css = sass_compile_file($sass_filename, $options);
    print $css;



# DESCRIPTION

Text::Sass::XS is a Perl Binding for libsass.

[libsass Project page](https://github.com/hcatlin/libsass)

# OO INTERFACE

- `new`

        $sass = Text::Sass::XS->new(options)

    Creates a Sass object with the specified options. Example:

        $sass = Text::Sass::XS->new; # no options
        $sass = Text::Sass::XS->new(output_style => SASS_STYLE_NESTED);

- `compile(source_code)`

        $css = $sass->compile("source code");

    This compiles the Sass string that is passed in the first parameter. If
    there is an error it will `croak()`, unless the `dont_die` option has been
    set. In that case, it will return `undef`.

- `compile_file(input_path)`

        $css = $sass->compile_file("/path/to/foo.scss");

    This compiles the Sass file that is passed in the first parameter. If
    there is an error it will `croak()`, unless the `dont_die` option has been
    set. In that case, it will return `undef`.

- `last_error`

        $sass->last_error

    Returns the error encountered by the most recent invocation of
    `compile`. This is really only useful if the `dont_die` option is set.

    `libsass` error messages are in the form ":$line:$column $error\_message" so
    you can append them to the filename for a standard looking error message.

- `options`

        $sass->options->{dont_die} = 1;

    Allows you to inspect or change the options after a call to `new`.

# FUNCTIONAL INTERFACE

# EXPORT

## Funcitons

None.

## Constants

- `SASS_STYLE_NESTED`
- `SASS_STYLE_COMPRESSED`

# EXPORT\_OK

## Funcitons

- `sass_compile($source_string :Str, $options :HashRef)`

    Returns css string if success. Otherwise throws exception.

    Default value of `$options` is below.

        my $options = {
            output_style    => SASS_STYLE_COMPRESSED,
            source_comments => SASS_SOURCE_COMMENTS_NONE, 
            include_paths   => undef,
            image_path      => undef,
        };

    `input_paths` is a coron-separated string for "@import". `image_path` is a string using for "image-url".

- `sass_compile_file($input_path :Str, $options :HashRef)`

    Returns css string if success. Otherwise throws exception. `$options` is same as `sass_compile`.

## Constants

For `$options->{output_style}`.

- `SASS_STYLE_NESTED`
- `SASS_STYLE_EXPANDED`
- `SASS_STYLE_COMPACT`
- `SASS_STYLE_COMPRESSED`

For `$options->{source_comments}`.

- `SASS_SOURCE_COMMENTS_NONE`
- `SASS_SOURCE_COMMENTS_DEFAULT`
- `SASS_SOURCE_COMMENTS_MAP`

# EXPORT\_TAGS

- :func

    Exports `sass_compile` and `sass_compile_file`.

- :const

    Exports all constants.

- :all

    Exports :func and :const.

# SEE ALSO

[Text::Sass](http://search.cpan.org/perldoc?Text::Sass)

# LICENSE

## Text::Sass::XS

Copyright (C) 2013 Yoshihiro Sasaki.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

## libsass

Copyright (C) 2012 by Hampton Catlin.

See libsass/LICENSE for more details.

# AUTHOR

Yoshihiro Sasaki <ysasaki@cpan.org>
