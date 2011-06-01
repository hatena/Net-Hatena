package Net::Hatena::Service::Nano;
use strict;
use warnings;
use parent qw(Net::Hatena::Service);

use JSON;
use Net::Hatena::User;

sub user {
    my $self = shift;
    my $res  = $self->oauth->get('http://n.hatena.com/applications/my.json');
    die $self->oauth->errstr if $res->is_error;

    my $data = decode_json($res->decoded_content || $res->content);
    Net::Hatena::User->new(%{$data || {}});
}

!!1;
