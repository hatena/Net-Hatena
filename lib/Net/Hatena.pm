package Net::Hatena;
use 5.008001;
use strict;
use warnings;

use UNIVERSAL::require;
use JSON qw(decode_json);

our $VERSION = '0.01';

use Class::Accessor::Lite (
    rw => [qw(
        consumer_key
        consumer_secret
        request_token

        _access_token
        access_token_secret

        _user
        _oauth
    )],
);

use Net::Hatena::User;
use Net::Hatena::OAuth;

sub new {
    my ($class, %args) = @_;
    my $self = bless \%args, $class;
}

sub user {
    my ($self, $user) = @_;

    if ($user) {
        $self->_user($user);
    }

    if (!$self->_user) {
        my $user = $self->service('Nano')->user;
        $self->_user($user);
    }

    $self->_user;
}

sub oauth {
    my ($self, $oauth) = @_;

    if ($oauth) {
        $self->_oauth($oauth);
    }

    if (!$self->_oauth) {
        $oauth = Net::Hatena::OAuth->new(
            options => {
                consumer_key    => $self->consumer_key,
                consumer_secret => $self->consumer_secret,
            },
        );
        $self->_oauth($oauth);
    }

    $self->_oauth;
}

sub access_token {
    my ($self, $access_token) = @_;

    if ($access_token) {
        $self->_access_token($access_token);
        $self->oauth->access_token($access_token);
    }

    $self->_access_token;
}

sub authorized {
    my $self = shift;
    defined $self->access_token && defined $self->access_token_secret;
}

sub get_authorization_url {
    my ($self, %args) = @_;
    my $request_token = $self->oauth->get_request_token(
        callback_url => $args{callback}          || '',
        scope        => join(',', (@{$args{scopes} || ['read_public']})) || '',
    ) or die $self->oauth->errstr;

    $self->request_token($request_token);
    $self->oauth->url_to_authorize(token => $request_token);
}

sub request_access_token {
    my ($self, %args) = @_;
    my $access_token = $self->oauth->get_access_token(
        token    => $args{request_token} || $self->request_token,
        verifier => $args{verifier},
    ) or die $self->oauth->errstr;

    $self->access_token($access_token->token);
    $self->access_token_secret($access_token->secret);

    $access_token;
}

sub service {
    my ($self, $service) = @_;
    my $class = join '::', __PACKAGE__, 'Service', ucfirst lc $service;
       $class->require or die $@;
       $class->new(oauth => $self->oauth);
}

!!1;

__END__

=encoding utf8

=head1 NAME

Net::Hatena -

=head1 SYNOPSIS

  use Net::Hatena;

=head1 DESCRIPTION

Net::Hatena is

=head1 AUTHOR

Kentaro Kuribayashi E<lt>kentarok@gmail.comE<gt>

=head1 SEE ALSO

=head1 LICENSE

Copyright (C) Kentaro Kuribayashi

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
