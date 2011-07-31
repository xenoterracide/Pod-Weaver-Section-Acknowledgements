package Pod::Weaver::Section::Acknowledgements;
use 5.008;
use strict;
use warnings;
BEGIN {
	# VERSION
}
use Moose;
use namespace::autoclean;
with 'Pod::Weaver::Role::Section';

use Moose::Autobox;

use Pod::Elemental::Element::Nested;
use Pod::Elemental::Element::Pod5::Verbatim;

sub weave_section {
	my ( $self, $document, $input ) = @_;

	return unless $input->{contributors};

	my $multiple_contributors = $input->{contributors}->length > 1;

	my $contributors
		= $input->{contributors}->map( sub {
			Pod::Elemental::Element::Pod5::Ordinary->new({
				content => $_,
		}),
	});

	$contributors
		= [
			Pod::Elementatal::Element::Pod5::Command->new({
				command => 'over', content => '4',
			}),
			$contributors->map( sub {
				Pod::Elementatal::Element::Pod5::Command->new({
					command => 'item', content => '*',
				}),
				$_,
			})->flatten,
			Pod::Elemental::Element::Pod5::Command->new({
				command  => 'back', content => '',
			}),
		] if $multiple_contributors;

	$document->children->push(
		Pod::Elemental::Element::Nested->new({
			type     => 'command',
			command  => 'head1',
			content  => 'ACKNOWLEDGEMENTS',
			children => $contributors,
		}),
	);
}

1;

# ABSTRACT: automatically add an ACKNOWLEDGMENTS section to pod
