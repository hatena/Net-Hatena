package Net::Hatena::User;
use strict;
use warnings;

sub new {
    my ($class, %args) = @_;
    bless \%args, $class;
}

our $AUTOLOAD;
sub AUTOLOAD {
    my $method = our $AUTOLOAD;
       $method =~ s/.*:://o;

    {
        no strict 'refs';
        *{$AUTOLOAD} = sub {
            my $self = shift;
               $self->{$method};
        };
    }

    goto &$AUTOLOAD;
}

!!1;
