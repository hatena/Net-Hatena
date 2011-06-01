package Net::Hatena::Service;
use strict;
use warnings;

use Class::Accessor::Lite (
    rw => [qw(
        oauth
    )],
);

sub new {
    my ($class, %args) = @_;
    bless \%args, $class;
}

!!1;
