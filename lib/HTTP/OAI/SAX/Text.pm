package HTTP::OAI::SAX::Text;

@ISA = qw( XML::SAX::Base );

use strict;

sub start_element
{
	( my $self, my $hash, @_ ) = @_;

	$self->{Data} = "";
	$self->{Attributes} = $hash->{Attributes};

	$self->SUPER::start_element( $hash, @_ );
}

sub characters { $_[0]->{Data} .= $_[1]->{Data} }

sub end_element
{
	( my $self, my $hash, @_ ) = @_;

	$hash->{Text} = $self->{Data};
	$hash->{Attributes} = $self->{Attributes};

	$self->SUPER::characters( {Data => $self->{Data}}, @_ );

	$self->{Data} = "";
	$self->{Attributes} = {};

	$self->SUPER::end_element( $hash, @_ );
}

1;

=head1 NAME

HTTP::OAI::SAX::Text

=head1 DESCRIPTION

This module adds Text and Attributes to the end_element call. This is only useful for leaf nodes (elements that don't contain any child elements).