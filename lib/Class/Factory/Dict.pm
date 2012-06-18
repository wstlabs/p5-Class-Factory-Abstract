package Class::Factory::Dict;
use warnings;
use strict;
use Carp qw( confess );
use Assert::Std qw(:types :class);
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
    my ($self, $desc) = @_;
    _assert_package_descriptor($desc);
    $self->{dict}->{$desc}
}

sub has_class  {
    my ($self, $desc) = @_;
    defined $self->get_class($desc)
}

sub register  {
    my ($self, $desc, $class) = @_;
    _assert_package_descriptor($desc);
    assert_valid_package_name($class);
    $self->{dict}->{$desc} = $class
}

sub unregister  {
    my ($self, $desc) = @_;
    _assert_package_descriptor($desc);
    delete $self->{dict}->{$desc}
}

sub register_all  {
    my $self = shift;
    confess "invalid usage:  odd number of arguments" if @_ % 2;
    while (@_)  {
        $self->register (shift, shift)
    }
}

sub _assert_package_descriptor  {
    my $desc = shift;
    confess "need a package descriptor" 
        unless defined $desc;
    confess "need a package descriptor" 
        unless is_scalar($desc);
    undef
}

1;

__END__

