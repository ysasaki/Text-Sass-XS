requires 'perl', '5.008001';

on 'test' => sub {
    requires 'Test::More',           '0.98';
    requires 'Test::Name::FromLine', '0.10';
};

on 'configure' => sub {
    requires 'ExtUtils::CBuilder' => '0.28';
};
