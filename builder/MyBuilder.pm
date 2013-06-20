package builder::MyBuilder;
use strict;
use warnings;
use base qw(Module::Build);
use Devel::PPPort;
use File::Spec;

sub new {
    my ( $self, %args ) = @_;

    print "Generating ppport.h\n";
    Devel::PPPort::WriteFile(
        File::Spec->catfile(qw/lib Text Sass ppport.h/) );

    $self->SUPER::new(
        %args,
        c_source             => ['libsass'],
        extra_compiler_flags => [ '-x', 'c++' ],
        extra_linker_flags   => ['-lstdc++'],
    );
}

sub compile_c {
    my $self = shift;

    # This logic is copied from M::B::Pluggable::XSUtil
    unless ($self->cbuilder->have_cplusplus) {
        warn
            "This environment does not have a C++ compiler(OS unsupported)\n";
        exit 0;
    };

    $self->SUPER::compile_c(@_);
}
1;
