package builder::MyBuilder;
use strict;
use warnings;
use parent qw(Module::Build);

sub new {
    my ( $self, %args ) = @_;
    $self->SUPER::new(
        %args,
        c_source => ['libsass'],
        config   => {
            cc => 'g++',
            ld => 'g++',
        }
    );
}

1;
