package Class::Factory::Abstract;
use warnings;
use strict;
use Scalar::Util  qw( reftype );
use Carp          qw( confess );
use Assert::Std   qw( :types :class );
use Module::Load;
use Class::Inspector;

our $VERSION = '0.003_001';

sub new {
    my $proto = shift;
    my $class = ref ($proto) || $proto;
    my $inst = bless {}, $class;
    $inst->initialize(@_);
    $inst
}

# MAY be provided by implementations; defaults to no-op.
sub initialize {}

#
#  takes:  @args
#  returns ($class, @opts)
#
# MUST be provided by implementations.
sub resolve      {  confess "not yet implemented"  }

sub instantiate  {
    my $self = shift;
    my ($class, @opts) = $self->resolve(@_);
    my $inst = $self->produce($class, \@opts);
    $inst
}

sub produce  {
    my $self  = shift;
    my $class = verify_package_name(shift);
    my $args  = verify_array_ref( shift // [] );
    load $class unless Class::Inspector->loaded($class);
    confess "can't produce:  class '$class' has no 'new' constructor"
        unless $class->can('new');
    $class->new(@$args)
} 

__END__

