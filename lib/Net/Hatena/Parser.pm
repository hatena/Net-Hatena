package Net::Hatena::Parser;
use strict;
use warnings;

use Class::Accessor::Lite (
    rw => [qw(
        parser
    )],
);

sub new {
    my ($class, %args) = @_;
    my $self = bless \%args, $class;
       $self->parser($self->init_parser);
       $self;
}

sub init_parser {}
sub parse {}

!!1;
