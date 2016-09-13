package ServerDensity::API::TypeRole;
use 5.008001;
use strict;
use warnings;
use Moose::Role;
use Moose::Util::TypeConstraints;

our $VERSION = "0.01";

enum 'SDType', [qw(device service widget)];

has "type" => (
    is  => 'rw',
    isa => 'SDType',
);

no Moose;

1;
__END__

=encoding utf-8

=head1 NAME

ServerDensity::API::TypeRole
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



