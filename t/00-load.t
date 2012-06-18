#!perl -T

use Test::More tests => 1;

BEGIN {
    use_ok( 'Class::Factory::Abstract' ) || print "Bail out!
";
}

diag( "Testing Class::Factory::Abstract $Class::Factory::Abstract::VERSION, Perl $], $^X" );
