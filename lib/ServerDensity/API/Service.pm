package ServerDensity::API::Service;
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

ServerDensity::API::Service - Perl representation of the ServerDensity API. Service Class.
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


