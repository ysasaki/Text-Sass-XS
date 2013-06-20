requires 'perl', '5.008001';

on 'recommends' => sub {
    requires 'Text::Sass', '0.97';
};

on 'test' => sub {
    requires 'Test::More',           '0.98';
    requires 'Test::Name::FromLine', '0.10';
};

on 'configure' => sub {
    requires 'ExtUtils::CBuilder', '0.28';
};

on 'build' => sub {
    requires 'Devel::PPPort';
};

on 'develop' => sub {
    requires 'Test::LeakTrace', '0.14';
};
