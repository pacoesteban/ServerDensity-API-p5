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

sub list_devices {
    my $self = shift;
    my $url  = $self->base_url . '/inventory/devices?token=' . $self->_token;
    my $res  = $self->_ua->get($url);
    if ( $res->is_success ) {
        my @devices;
        foreach my $d ( @{ decode_json $res->decoded_content } ) {
            push @devices,
              ServerDensity::API::Device->new(
                _token => $self->_token,
                %{$d}
              );
        }
        return \@devices;
    }
    return $res->code;
}

sub list_services {
    my $self = shift;
    my $url  = $self->base_url . '/inventory/services?token=' . $self->_token;
    my $res  = $self->_ua->get($url);
    if ( $res->is_success ) {
        my @services;
        foreach my $d ( @{ decode_json $res->decoded_content } ) {
            push @services,
              ServerDensity::API::Service->new(
                _token => $self->_token,
                %{$d}
              );
        }
        return \@services;
    }
    return $res->code;
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
    my $devices = $api->device->list;
    my $device = $api->device->create( name => 'Llama' );

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

