use strict;
use warnings;
use Test::More;

use Net::Hatena;

plan skip_all => 'set set $ENV{NET_HATENA_*} for livetest'
    if !$ENV{NET_HATENA_LIVETEST} ||
       (!$ENV{NET_HATENA_CONSUMER_KEY} || !$ENV{NET_HATENA_CONSUMER_SECRET});

subtest 'authenticate' => sub {
    local $| = 1;

    my $hatena = Net::Hatena->new(
        consumer_key    => $ENV{NET_HATENA_CONSUMER_KEY},
        consumer_secret => $ENV{NET_HATENA_CONSUMER_SECRET},
    );

    ok !$hatena->authorized, 'not authorized yet';

    my $authorization_url = $hatena->get_authorization_url(
        callback => 'http://localhost/callback',
    );
    ok $authorization_url, 'got authorization url';
    ok $hatena->request_token, 'got request token';

    diag("open $authorization_url and input callback url:");
    my $callback_url = <STDIN>;
    my ($verifier) = ($callback_url =~ /\boauth_verifier=([^&;\s]+)/);

    my $access_token = $hatena->request_access_token(
        verifier => $verifier,
    );

    ok $access_token,                'got access token object';
    ok $access_token->token,         'got access token';
    ok $hatena->access_token,        'got access token';
    ok $access_token->secret,        'got access token secret';
    ok $hatena->access_token_secret, 'got access token';
    ok $hatena->authorized,          'now authorized';

    my $user = $hatena->user;

    ok     $user, 'got user information';
    isa_ok $user, 'Net::Hatena::User';
    ok     $user->url_name, 'url name';
};

done_testing;
