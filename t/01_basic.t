use strict;
use Test::More 0.98;
use Config::Simple;
use ServerDensity::API;

my $token = 'testtoken';
if ( -f $ENV{HOME} . "/.sd-config" ) {
    my $cfg = new Config::Simple( $ENV{HOME} . "/.sd-config" );
    $token = $cfg->param('token');
}

my $api = ServerDensity::API->new( _token => $token );

isa_ok( $api, 'ServerDensity::API' );
can_ok( $api, qw[_token _ua list_devices] );

done_testing;

