package ServerDensity::API;
use 5.008001;
use strict;
use warnings;
use Data::Dumper;
use JSON;
use Moose;
extends 'ServerDensity::API::Base';

use ServerDensity::API::Device;
use ServerDensity::API::Service;

our $VERSION = "0.01";

has device => (
    is      => 'rw',
    isa     => 'ServerDensity::API::Device',
    default => sub {
        my $self = shift;
        return ServerDensity::API::Device->new( _token => $self->_token );
    },
);

has service => (
    is      => 'rw',
    isa     => 'ServerDensity::API::Service',
    default => sub {
        my $self = shift;
        return ServerDensity::API::Service->new( _token => $self->_token );
    },
);

# list_devices and list_services are basically the same
# so a bit of meta-programming won't hurt.
foreach my $method (qw/devices services/) {
    __PACKAGE__->meta->add_method(
        "list_" . $method,
        sub {
            my $self = shift;
            my $url
              = $self->base_url
              . '/inventory/'
              . $method
              . '?token='
              . $self->_token;
            my $res = $self->_ua->get($url);
            my ($singular_method) = $method =~ m/(.*)s$/;
            my $class = "ServerDensity::API::" . ucfirst $singular_method;
            if ( $res->is_success ) {
                my @i;
                foreach my $d ( @{ decode_json $res->decoded_content } ) {
                    push @i,
                      $class->new(
                        _token => $self->_token,
                        %{$d}
                      );
                }
                return \@i;
            }
            return $res->code;
        }
    );
}

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
    my $devices = $api->list_devices; # returns an array of ServerDensity::API::Device
    my $devices = $api->list_services; # returns an array of ServerDensity::API::Services

    my $device = $api->device->new( name => 'Llama' ); # new device object
    $device->create; # actually queries the api for creation.
    # check ServerDensity::API::Device for more info.

    ...

=head1 DESCRIPTION

ServerDensity::API is a module to interact with ServerDensity monitoring service.
It works with version 2.0 of the API.

=head1 ATTRIBUTES

=head2 _token

This is mandatory. You need to provide a valid token to operate with the rest of attributes and methods.
You can generate one on ServerDensity web UI. For now, this module does not provide the ability to generate new tokens from credentials.

=head2 device

Returns L<ServerDensity::API::Device> object you can act on.

=head2 service

Returns L<ServerDensity::API::Service> object you can act on.

=head1 METHODS

=head2 new

Main constructor. you shoud only use this one, since you can access all objects from here.

=head2 list_devices

Returns an array of L<ServerDensity::API::Device>

=head2 list_services

Returns an array of L<ServerDensity::API::Service>

=head1 LICENSE

Copyright (C) Paco Esteban.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

Paco Esteban E<lt>paco@onna.beE<gt>

=cut

