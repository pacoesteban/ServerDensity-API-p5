use strict;
use Test::More 0.98;
use ServerDensity::API;

my $api = ServerDensity::API->new( _token => 'mytoken' );

can_ok($api->device, qw[_id name type deleted agentKey]);

done_testing;

