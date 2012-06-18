package Class::Factory::Dict;
use warnings;
use strict;
use Carp qw( confess );
use Assert::Class qw(:all);
use Class::Factory::Dict::Assert qw(:all);
use parent 'Class::Factory::Abstract';

sub initialize  {
    my $self = shift;
    $self->{'dict'} = {};
    $self->register_all(@_)
}

# 'hard' accessor; dies if not registered.
sub resolve  {
    my ($self, $desc, @opts) = @_; 
    my $class = $self->get_class($desc);
    confess "no package registered for descriptor '$desc'"
        unless defined $class;
    ($class, @opts)
}


sub get_keys  {
    my $self = shift;
    keys %{ $self->{dict} }
}

# 'soft' accesser; returns undef if not registerd.
sub get_class  {
    my $self = shift;
    my $desc = verify_package_descriptor(shift);
    $self->{dict}->{$desc}
}

sub has_class  {
    my $self = shift;
    my $desc = verify_package_descriptor(shift);
    defined $self->get_class($desc)
}

sub register  {
    my $self  = shift;
    my $desc  = verify_package_descriptor(shift);
    my $class = verify_package_name(shift);
    $self->{dict}->{$desc} = $class
}

sub unregister  {
    my $self = shift;
    my $desc = verify_package_descriptor(shift);
    delete $self->{dict}->{$desc}
}

sub register_all  {
    my $self = shift;
    confess "invalid usage:  odd number of arguments" if @_ % 2;
    while (@_)  {
        $self->register (shift, shift)
    }
}

1;

__END__

