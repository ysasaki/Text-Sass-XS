use utf8;
use strict;
use warnings;
use Test::More;
use Text::Sass::XS qw(:const);

my $sass = <<'SASS';
$blue: #3bbfce;
$margin: 16px;

.content-navigation {
  border-color: $blue;
}

.border {
  padding: $margin / 2;
  margin: $margin / 2;
}
SASS

my $options = {
    output_style    => SASS_STYLE_COMPRESSED,
    source_comments => SASS_SOURCE_COMMENTS_NONE,
    include_paths   => undef,
    image_path      => undef,
};
my $css = Text::Sass::XS->compile($sass, $options);
is $css, <<'CSS', 'compile with options';
.content-navigation{border-color:#3bbfce;}.border{padding:8px;margin:8px;}
CSS

$css = Text::Sass::XS->compile($sass);
is $css, <<'CSS', 'compile without options';
.content-navigation{border-color:#3bbfce;}.border{padding:8px;margin:8px;}
CSS

done_testing;
