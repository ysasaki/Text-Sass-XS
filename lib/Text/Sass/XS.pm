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
our @EXPORT_OK = @constants;
our %EXPORT_TAGS = ( 'const' => \@constants );

use XSLoader;
XSLoader::load( __PACKAGE__, $VERSION );

1;
__END__

=encoding utf-8

=head1 NAME

Text::Sass::XS - It's new $module

=head1 SYNOPSIS

    use Text::Sass::XS;

=head1 DESCRIPTION

Text::Sass::XS is ...

=head1 LICENSE

Copyright (C) ysasaki.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

ysasaki E<lt>ysasaki@idac.co.jpE<gt>

=cut

