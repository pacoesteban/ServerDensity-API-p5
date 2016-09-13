package ServerDensity::API;
use 5.008001;
use strict;
use warnings;
use Moose;
extends 'ServerDensity::API::Base';

use ServerDensity::API::Device;

our $VERSION = "0.01";

has device => (
    is      => 'rw',
    isa     => 'ServerDensity::API::Device',
    default => sub {
        my $self = shift;
        return ServerDensity::API::Device->new( _token => $self->_token );
    },
);

no Moose;
__PACKAGE__->meta->make_immutable;

1;
__END__

=encoding utf-8

=head1 NAME

ServerDensity::API - Perl representation of the ServerDensity API.
L<http://serverdensity.com>

=head1 SYNOPSIS

    use ServerDensity::API;

    my $api = ServerDensity::API->new( _token => 'mytoken' );
    my $device = $api->device->new( name => 'Llama' );

    ...

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

