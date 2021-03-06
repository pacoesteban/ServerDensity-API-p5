use strict;
use Test::More 0.98;
use Config::Simple;
use ServerDensity::API::Device;

my $token = 'testtoken';
if ( -f $ENV{HOME} . "/.sd-config" ) {
    my $cfg = new Config::Simple( $ENV{HOME} . "/.sd-config" );
    $token = $cfg->param('token');
}

my $device = ServerDensity::API::Device->new( _token => $token );

isa_ok( $device, 'ServerDensity::API::Device' );
can_ok( $device, qw[_id name type deleted agentKey] );

done_testing;

