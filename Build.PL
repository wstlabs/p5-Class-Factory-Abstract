use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'Class::Factory::Abstract',
    license             => 'perl',
    dist_author         => q{WST <wst@cpan.org>},
    dist_version_from   => 'lib/Class/Factory/Abstract.pm',
    dist_abstract       => 'A simple abstract factory class', 
    build_requires => {
        'Test::More' => 0,
        'Exporter::Tidy' => 0.07,
        'Module::Load'   => 0.12,
        'Class::Inspector' => 1.24
    },
    add_to_cleanup      => [ 'Class-Factory-Abstract-*' ],
    create_makefile_pl => 'traditional',
);

$builder->create_build_script();
