use utf8;
use strict;
use warnings;
use Test::More;
use Text::Sass::XS qw(:all);
use FindBin qw($Bin);
use File::Spec::Functions qw(catfile);

my $sass = catfile( $Bin, qw/assets foo.scss/ );

my $options = {
    output_style    => SASS_STYLE_COMPRESSED,
    source_comments => SASS_SOURCE_COMMENTS_NONE,
    include_paths   => undef,
    image_path      => undef,
};
my $css = sass_compile_file( $sass, $options );
is $css, <<'CSS', 'compile_file with options';
.content-navigation{border-color:#3bbfce;}.border{padding:8px;margin:8px;}
CSS

$css = sass_compile_file($sass);
is $css, <<'CSS', 'compile_file without options';
.content-navigation{border-color:#3bbfce;}.border{padding:8px;margin:8px;}
CSS

done_testing;
