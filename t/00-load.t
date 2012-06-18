#!perl -T

use Test::More tests => 2;

BEGIN {
    use_ok( 'Class::Factory::Abstract' ) || print "you no good";
    use_ok( 'Class::Factory::Dict'     ) || print "you no good";
}

diag( "Testing Class::Factory::Abstract $Class::Factory::Abstract::VERSION, Perl $], $^X" );
