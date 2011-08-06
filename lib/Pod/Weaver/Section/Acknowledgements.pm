package Pod::Weaver::Section::Acknowledgements;
use 5.008;
use strict;
use warnings;
BEGIN {
	our $VERSION = '0.1.0'; # VERSION
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
	return 1;
}

1;

# ABSTRACT: automatically add an ACKNOWLEDGMENTS section to pod

__END__
=pod

=head1 NAME

Pod::Weaver::Section::Acknowledgements - automatically add an ACKNOWLEDGMENTS section to pod

=head1 VERSION

version 0.1.0

=head1 ATTRIBUTES

=head2 plugin_name

Reader: plugin_name

Type: Str

This attribute is required.

This documentation was automatically generated.

=head2 logger

Reader: logger

This documentation was automatically generated.

=head2 weaver

Reader: weaver

Type: Pod::Weaver

This attribute is required.

This documentation was automatically generated.

=head1 METHODS

=head2 plugin_name

Method originates in Pod::Weaver::Section::Acknowledgements.

This documentation was automaticaly generated.

=head2 log_fatal

Method originates in Pod::Weaver::Section::Acknowledgements.

This documentation was automaticaly generated.

=head2 log

Method originates in Pod::Weaver::Section::Acknowledgements.

This documentation was automaticaly generated.

=head2 logger

Method originates in Pod::Weaver::Section::Acknowledgements.

This documentation was automaticaly generated.

=head2 weave_section

Method originates in Pod::Weaver::Section::Acknowledgements.

This documentation was automaticaly generated.

=head2 weaver

Method originates in Pod::Weaver::Section::Acknowledgements.

This documentation was automaticaly generated.

=head2 log_debug

Method originates in Pod::Weaver::Section::Acknowledgements.

This documentation was automaticaly generated.

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website
https://github.com/xenoterracide/Pod-Weaver-Section-Acknowledgements/issues

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=head1 AUTHOR

Caleb Cushing <xenoterracide@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2011 by Caleb Cushing.

This is free software, licensed under:

  The Artistic License 2.0 (GPL Compatible)

=cut

