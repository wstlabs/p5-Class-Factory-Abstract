#
# a simple demonstration of anonymous factory intitialization. 
#
use strict;
use warnings;
use Class::Factory::Dict;
use Carp;
use YAML;

our $DF = Class::Factory::Dict->new(
    'md5'   => 'Digest::MD5',
    'sha1'  => 'Digest::SHA1'
);

print "fac = " . Dump $DF; 
my @keys = $DF->get_keys();
print "keys = " . Dump \@keys; 

print "instances:\n";
for my $alg ($DF->get_keys)  {
    my $digest = $DF->instantiate($alg);
    print "$alg: $digest\n";
}

