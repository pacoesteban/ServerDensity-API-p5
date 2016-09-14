use strict;
use Test::More 0.98;
use Config::Simple;
use ServerDensity::API;

my $token = 'testtoken';
if ( -f $ENV{HOME} . "/.sd-config" ) {
    my $cfg = new Config::Simple( $ENV{HOME} . "/.sd-config" );
    $token = $cfg->param('token');
}

my $api      = ServerDensity::API::->new( _token => $token );
my $devices  = $api->list_devices;
my $services = $api->list_services;

isa_ok( $devices, 'ARRAY' );

# 57a06dca95fe35277b8b4567
like( $devices->[0]->_id, qr/[a-zA-Z0-9]{24}/, 'Id format' );

# 57a06dca95fe35277b8b4567
like( $services->[0]->_id, qr/[a-zA-Z0-9]{24}/, 'Id format' );

done_testing;

