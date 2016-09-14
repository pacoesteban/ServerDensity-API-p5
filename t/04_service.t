use strict;
use Test::More 0.98;
use Config::Simple;
use ServerDensity::API::Service;

my $token = 'testtoken';
if ( -f $ENV{HOME} . "/.sd-config" ) {
    my $cfg = new Config::Simple( $ENV{HOME} . "/.sd-config" );
    $token = $cfg->param('token');
}

my $device = ServerDensity::API::Service->new( _token => $token );

isa_ok( $device, 'ServerDensity::API::Service' );
can_ok( $device, qw[_id name type deleted createdAt] );

done_testing;

