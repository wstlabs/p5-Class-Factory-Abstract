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
    my $class = shift;
    my $args  = shift // [];
    assert_valid_package_name($class);
    assert_array_ref($args);
    load $class unless Class::Inspector->loaded($class);
    confess "can't produce:  class '$class' has no 'new' constructor"
        unless $class->can('new');
    $class->new(@$args)
} 

__END__

=head1 NAME

Class::Factory::Abstract - The great new Class::Factory::Abstract!

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';


=head1 SYNOPSIS

Quick summary of what the module does.

Perhaps a little code snippet.

    use Class::Factory::Abstract;

    my $foo = Class::Factory::Abstract->new();
    ...

=head1 EXPORT

A list of functions that can be exported.  You can delete this section
if you don't export anything, such as for a purely object-oriented module.

=head1 SUBROUTINES/METHODS

=head2 function1

=cut

sub function1 {
}

=head2 function2

=cut

sub function2 {
}

=head1 AUTHOR

WST, C<< <wst at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-class-factory-abstract at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Class-Factory-Abstract>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Class::Factory::Abstract


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Class-Factory-Abstract>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Class-Factory-Abstract>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Class-Factory-Abstract>

=item * Search CPAN

L<http://search.cpan.org/dist/Class-Factory-Abstract/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2012 WST.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.


=cut

1; # End of Class::Factory::Abstract

