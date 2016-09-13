requires 'perl', '5.008001';
requires 'Moose';
requires 'LWP::UserAgent';
requires 'JSON';

on 'test' => sub {
    requires 'Test::More', '0.98';
};

