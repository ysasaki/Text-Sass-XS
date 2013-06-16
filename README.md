# NAME

Text::Sass::XS - Perl Binding for libsass

# SYNOPSIS

    # export sass_compile, sass_compile_file and some constants
    use Text::Sass::XS ':all';
    use Try::Tiny;

    my $sass = "your sass string here...";
    my $options = {
        output_style    => SASS_STYLE_COMPRESSED,
        source_comments => SASS_SOURCE_COMMENTS_NONE,
        include_paths   => 'site/css:vendor/css',
        image_path      => '/images'
    };
    try {
        my $css = sass_compile($sass, $options);
        print $css;
    }
    catch {
        warn $_;
    };

    my $sass_filename = "/path/to/foo.scss";
    my $options = {
        output_style    => SASS_STYLE_COMPRESSED,
        source_comments => SASS_SOURCE_COMMENTS_NONE,
        include_paths   => 'site/css:vendor/css',
        image_path      => '/images'
    };
    try {
        my $css = sass_compile_file($sass_filename, $options);
        print $css;
    }
    catch {
        warn $_;
    };



# DESCRIPTION

Text::Sass::XS is a Perl Binding for libsass.

[libsass Project page](https://github.com/hcatlin/libsass)

[CSS::Sass](http://search.cpan.org/perldoc?CSS::Sass) is also using libsass. But CSS::Sass v0.1.0 and v0.2.0 are both broken.

# EXPORT

None.

# EXPORT\_OK

## Funcitons

- sass\_compile($source\_string :Str, $options :HashRef)

    Returns css string if success. Otherwise throws exception.

    Default value of `$options` is below.

        my $options = {
            output_style    => SASS_STYLE_COMPRESSED,
            source_comments => SASS_SOURCE_COMMENTS_NONE, 
            include_paths   => undef,
            image_path      => undef,
        };

    `input_paths` is a coron-separated string for "@import". `image_path` is a string using for "image-url".

- sass\_compile\_file($input\_path :Str, $options :HashRef)

    Returns css string if success. Otherwise throws exception. `$options` is same as `sass_compile`.

## Constants

For `$options->{output_style}`.

- SASS\_STYLE\_NESTED
- SASS\_STYLE\_EXPANDED
- SASS\_STYLE\_COMPACT
- SASS\_STYLE\_COMPRESSED

For `$options->{source_comments}`.

- SASS\_SOURCE\_COMMENTS\_NONE
- SASS\_SOURCE\_COMMENTS\_DEFAULT
- SASS\_SOURCE\_COMMENTS\_MAP

# EXPORT\_TAGS

- :func

    Exports sass\_compile and sass\_compile\_file.

- :const

    Exports all constants.

- :all

    Exports :func and :const.

# SEE ALSO

[Text::Sass](http://search.cpan.org/perldoc?Text::Sass)

[CSS::Sass](http://search.cpan.org/perldoc?CSS::Sass)

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
