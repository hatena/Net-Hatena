package Net::Hatena::Service::Nano;
use strict;
use warnings;
use parent qw(Net::Hatena::Service);

use Net::Hatena::User;
use Net::Hatena::Parser::JSON;

sub user {
    my $self = shift;
    my $res  = $self->oauth->get('http://n.hatena.com/applications/my.json');
    die $self->oauth->errstr if $res->is_error;

    my $parser = Net::Hatena::Parser::JSON->new;
    my $data   = $parser->parse($res->decoded_content || $res->content);

    Net::Hatena::User->new(%{$data || {}});
}

!!1;
