package ServerDensity::API::Base;
use 5.008001;
use strict;
use warnings;
use Moose;
use LWP::UserAgent;

our $VERSION = "0.01";

has _token => (
    is       => 'ro',
    isa      => 'Str',
    required => 1
);

has _ua => (
    is      => 'ro',
    isa     => 'LWP::UserAgent',
    default => sub {
        LWP::UserAgent->new;
    },
);

no Moose;
__PACKAGE__->meta->make_immutable;

1;
__END__

=encoding utf-8

=head1 NAME

ServerDensity::API::Base - Perl representation of the ServerDensity API. Base Class.
L<http://serverdensity.com>

=head1 SYNOPSIS

See L<ServerDensity::API>

=head1 DESCRIPTION

ServerDensity::API is a module to interact with ServerDensity monitoring service.
It works with version 2.0 of the API.

=head1 LICENSE

Copyright (C) Paco Esteban.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

Paco Esteban E<lt>paco@onna.beE<gt>

=cut


