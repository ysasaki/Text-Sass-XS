package builder::MyBuilder;
use strict;
use warnings;
use parent qw(Module::Build);

sub new {
    my ( $self, %args ) = @_;
    $self->SUPER::new(
        %args,
        extra_compiler_flags => [ '-x' => 'c++' ],
        c_source             => ['libsass'],
    );
}

1;
