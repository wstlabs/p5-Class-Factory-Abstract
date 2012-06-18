package Class::Factory::Dict::Assert;
use warnings;
use strict;
use Carp qw( confess );
use Scalar::Util qw( reftype );
use Exporter::Tidy 
    other => [qw| 
        assert_package_descriptor
        verify_package_descriptor
    |]
;

sub assert_package_descriptor  {
    my $desc = shift;
    confess "need a package descriptor" 
        unless defined $desc;
    confess "invalid a package descriptor (not a SCALAR)" 
        if defined reftype $desc;
    undef
}

sub verify_package_descriptor  { assert_package_descriptor($_[0]); $_[0] }

1;

__END__

