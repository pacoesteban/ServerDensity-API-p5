package ServerDensity::API::Device;
use 5.008001;
use strict;
use warnings;
use Moose;
use JSON;
use DateTime::Format::ISO8601;

our $VERSION = "0.01";

extends 'ServerDensity::API::Base';
with 'ServerDensity::API::BaseRole',
  'ServerDensity::API::NameRole',
  'ServerDensity::API::TypeRole',
  'ServerDensity::API::GroupRole',
  'ServerDensity::API::DateRole',
  'ServerDensity::API::DeleteRole',
  'ServerDensity::API::TagRole';

has [qw(agentKey agentVersion hostname ip provider userId cId imageId status)]
  => (
    is  => 'rw',
    isa => 'Str',
  );

has [qw(installedRAM swapSpace cpuCores)] => (
    is  => 'rw',
    isa => 'Int',
);

has [qw(cloud isMonitored isNew)] => (
    is  => 'rw',
    isa => 'Bool',
);

has [qw(location lastPayloadAt os )] => (
    is  => 'rw',
    isa => 'Maybe[HashRef]',
);

has [qw(pluginsEnabled privateIPs publicIPs)] => (
    is  => 'rw',
    isa => 'Maybe[ArrayRef]',
);

around BUILDARGS => sub {
    my ( $orig, $class, %args ) = @_;
    if ( $args{createdAt} ) {
        $args{createdAt}
          = DateTime::Format::ISO8601->parse_datetime( $args{createdAt} );
    }
    if ( $args{updatedAt} ) {
        $args{updatedAt}
          = DateTime::Format::ISO8601->parse_datetime( $args{updatedAt} );
    }
    return $class->$orig(%args);
};

no Moose;
__PACKAGE__->meta->make_immutable;

1;
__END__

=encoding utf-8

=head1 NAME

ServerDensity::API::Base - Perl representation of the ServerDensity API. Device Class.
L<http://serverdensity.com>

=head1 SYNOPSIS

See L<ServerDensity::API>

=head1 DESCRIPTION

ServerDensity::API is a module to interact with ServerDensity monitoring service.
It works with version 2.0 of the API.

=head1 ATTRIBUTES

=head2 _token

This is mandatory. the main class ensures this is passed to this child class.

=head2 _id name type  ...

All attributes as described on the API docs are presented on this object.

=head1 METHODS

=head2 new

Constructor method. Not ment to be used alone. You should instantiate it from main class.

=head2 create delete update


=head1 LICENSE

Copyright (C) Paco Esteban.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

Paco Esteban E<lt>paco@onna.beE<gt>

=cut

