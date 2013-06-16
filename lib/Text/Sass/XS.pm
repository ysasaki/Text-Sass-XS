package Text::Sass::XS;
use 5.008005;
use strict;
use warnings;
use base 'Exporter';

our $VERSION = "0.01";

my @constants = qw(
    SASS_STYLE_NESTED
    SASS_STYLE_EXPANDED
    SASS_STYLE_COMPACT
    SASS_STYLE_COMPRESSED
    SASS_SOURCE_COMMENTS_NONE
    SASS_SOURCE_COMMENTS_DEFAULT
    SASS_SOURCE_COMMENTS_MAP
);
my @functions = qw(
    sass_compile
    sass_compile_file
);
our @EXPORT_OK = ( @constants, @functions );
our %EXPORT_TAGS = (
    'all'   => [ @constants, @functions ],
    'const' => \@constants,
    'func'  => \@functions
);

use XSLoader;
XSLoader::load( __PACKAGE__, $VERSION );

sub sass_compile      { Text::Sass::XS::compile(@_) }
sub sass_compile_file { Text::Sass::XS::compile_file(@_) }

1;
__END__

=encoding utf-8

=head1 NAME

Text::Sass::XS - Perl Binding for libsass

=head1 SYNOPSIS

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


=head1 DESCRIPTION

Text::Sass::XS is a Perl Binding for libsass.

libsass https://github.com/hcatlin/libsass

=head1 EXPORT

None.

=head1 EXPORT_OK

=head2 Funcitons

=over 4

=item sass_compile($source_string :Str, $options :HashRef)

Returns css string if success. Otherwise throws exception.

Default value of C<$options> is below.

    my $options = {
        output_style    => SASS_STYLE_COMPRESSED,
        source_comments => SASS_SOURCE_COMMENTS_NONE, 
        include_paths   => undef,
        image_path      => undef,
    };

C<input_paths> is a coron-separated string for "@import". C<image_path> is a string using for "image-url".

=item sass_compile_file($input_path :Str, $options :HashRef)

Returns css string if success. Otherwise throws exception. C<$options> is same as C<sass_compile>.

=back

=head2 Constants

For C<$options-E<gt>{output_style}>.

=over 4

=item SASS_STYLE_NESTED

=item SASS_STYLE_EXPANDED

=item SASS_STYLE_COMPACT

=item SASS_STYLE_COMPRESSED

=back

For C<$options-E<gt>{source_comments}>.

=over 4

=item SASS_SOURCE_COMMENTS_NONE

=item SASS_SOURCE_COMMENTS_DEFAULT

=item SASS_SOURCE_COMMENTS_MAP

=back

=head1 EXPORT_TAGS

=over 4

=item :func

Exports sass_compile and sass_compile_file.

=item :const

Exports all constants.

=item :all

Exports :func and :const.

=back

=head1 LICENSE

Copyright (C) 2013 Yoshihiro Sasaki.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 SEE ALSO

L<Text::Sass>

=head1 AUTHOR

Yoshihiro Sasaki E<lt>ysasaki@cpan.orgE<gt>

=cut

