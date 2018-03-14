use 5.10.0;
use strict;
use warnings;

package OpenGbg::Service::Getter;

# AUTHORITY
our $VERSION = '0.1404';

use Moose::Role;
use OpenGbg::Exceptions;

sub getter {
    my $self = shift;
    my $service_url = shift;
    my $service_name = shift;

    $service_url = sprintf $service_url, $self->handler->key;
    my $url = $self->handler->base . $self->service_base . $service_url.'format=xml';

    my $response = $self->handler->get($url);

    if(!$response->{'success'}) {
        die bad_response_from_service service => join ('::', $self, $service_name), url => $response->{'url'}, status => $response->{'status'}, reason => $response->{'reason'};
    }
    return $response->{'content'};
}

1;
