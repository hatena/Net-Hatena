package Net::Hatena::OAuth;
use strict;
use warnings;

use parent qw(OAuth::Lite::Consumer);

sub new {
    my ($class, %args) = @_;
    my $self = $class->SUPER::new(
        site               => 'https://www.hatena.com',
        request_token_path => '/oauth/initiate',
        access_token_path  => '/oauth/token',
        authorize_path     => 'https://www.hatena.ne.jp/oauth/authorize',
        %args
    );
    $self;
}

!!1;
