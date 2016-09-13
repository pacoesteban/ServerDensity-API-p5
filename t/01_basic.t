use strict;
use Test::More 0.98;
use ServerDensity::API;

my $api = ServerDensity::API->new( _token => 'mytoken' );

isa_ok($api, 'ServerDensity::API');
isa_ok($api->device, 'ServerDensity::API::Device');

done_testing;

