package builder::MyBuilder;
use strict;
use warnings;
use parent qw(Module::Build);

sub new {
    my ( $self, %args ) = @_;
    $self->SUPER::new(
        %args,
        c_source             => ['libsass'],
        extra_compiler_flags => [ '-x', 'c++' ],
        extra_linker_flags   => ['-lstdc++'],
    );
}

# Copy from Module::Build::Pluggable::XSUtil
sub HOOK_configure {
    my $self = shift;

    # c++ options
    if ( $self->{'c++'} ) {
        require ExtUtils::CBuilder;
        my $cbuilder = ExtUtils::CBuilder->new( quiet => 1 );
        $cbuilder->have_cplusplus or do {
            warn
                "This environment does not have a C++ compiler(OS unsupported)\n";
            exit 0;
        };
    }
}

1;
