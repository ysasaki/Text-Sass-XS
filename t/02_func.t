use utf8;
use strict;
use warnings;
use Test::More;
use Test::Name::FromLine;
use Text::Sass::XS qw(:func);

can_ok 'Text::Sass::XS', $_ for qw(new options compile compile_file);
can_ok 'main',           $_ for qw(sass_compile sass_compile_file);

done_testing;
