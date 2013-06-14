package builder::MyBuilder;
use strict;
use warnings;
use parent qw(Module::Build);

sub new {
    my ($self, %args) = @_;
    $self->SUPER::new(
        %args,
        extra_linker_flags => ['-lsass'],
    );
}

1;
