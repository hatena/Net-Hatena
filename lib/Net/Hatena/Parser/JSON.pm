package Net::Hatena::Parser::JSON;
use strict;
use warnings;
use parent qw(Net::Hatena::Parser);

use JSON;

sub init_parser {
    my $self = shift;
    JSON->new->utf8;
}

sub parse {
    my ($self, $json) = @_;
    $self->parser->decode($json);
}

!!1;
