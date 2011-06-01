package Net::Hatena::OAuth;
use strict;
use warnings;

use OAuth::Lite::Consumer;

use Class::Accessor::Lite (
    rw => [qw(
        consumer
        access_token
    )],
);

sub new {
    my ($class, %args) = @_;
    my $self = bless {}, $class;
    $self->consumer(OAuth::Lite::Consumer->new(
        site               => 'https://www.hatena.com',
        request_token_path => '/oauth/initiate',
        access_token_path  => '/oauth/token',
        authorize_path     => 'https://www.hatena.ne.jp/oauth/authorize',
        %{$args{options} || {}},
    ));
    $self->access_token($args{access_token});
    $self;
}

our $AUTOLOAD;
sub AUTOLOAD {
    my $method = our $AUTOLOAD;
       $method =~ s/.*:://o;

    return if $method eq 'DESTROY';

    {
        no strict 'refs';
        *{$AUTOLOAD} = sub {
            my $self = shift;
               $self->consumer->$method(@_);
        };
    }

    goto &$AUTOLOAD;
}

!!1;
