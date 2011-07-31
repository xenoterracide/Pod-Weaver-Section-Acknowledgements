
use strict;
use warnings;

use 5.008;

use ExtUtils::MakeMaker 6.30;



my %WriteMakefileArgs = (
  'ABSTRACT' => 'automatically add an ACKNOWLEDGMENTS section to pod',
  'AUTHOR' => 'Caleb Cushing <xenoterracide@gmail.com>',
  'BUILD_REQUIRES' => {
    'English' => '0',
    'File::Find' => '0',
    'File::Temp' => '0',
    'Test::More' => '0'
  },
  'CONFIGURE_REQUIRES' => {
    'ExtUtils::MakeMaker' => '6.30'
  },
  'DISTNAME' => 'Pod-Weaver-Section-Acknowledgements',
  'EXE_FILES' => [],
  'LICENSE' => 'artistic_2',
  'NAME' => 'Pod::Weaver::Section::Acknowledgements',
  'PREREQ_PM' => {
    'Moose' => '0',
    'Moose::Autobox' => '0',
    'Pod::Elemental::Element::Nested' => '0',
    'Pod::Elemental::Element::Pod5::Verbatim' => '0',
    'Pod::Weaver::Role::Section' => '0',
    'namespace::autoclean' => '0'
  },
  'VERSION' => '0.1.0',
  'test' => {
    'TESTS' => 't/*.t'
  }
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.56) } ) {
  my $br = delete $WriteMakefileArgs{BUILD_REQUIRES};
  my $pp = $WriteMakefileArgs{PREREQ_PM};
  for my $mod ( keys %$br ) {
    if ( exists $pp->{$mod} ) {
      $pp->{$mod} = $br->{$mod} if $br->{$mod} > $pp->{$mod};
    }
    else {
      $pp->{$mod} = $br->{$mod};
    }
  }
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);



