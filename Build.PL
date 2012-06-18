use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'Class::Factory::Abstract',
    license             => 'perl',
    dist_author         => q{WST <wst@cpan.org>},
    dist_version_from   => 'lib/Class/Factory/Abstract.pm',
    build_requires => {
        'Test::More' => 0,
    },
    add_to_cleanup      => [ 'Class-Factory-Abstract-*' ],
    create_makefile_pl => 'traditional',
);

$builder->create_build_script();
