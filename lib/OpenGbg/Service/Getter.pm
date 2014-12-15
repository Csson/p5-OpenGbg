use 5.14.0;

package OpenGbg::Service::Getter {

    use Moose::Role;
    use Kavorka;
    use aliased 'OpenGbg::Exception::BadResponseFromService';

    method getter($service_url, $service_name) {
        $service_url = sprintf $service_url, $self->handler->key;
        my $url = $self->handler->base . $self->service_base . $service_url.'format=xml';

        my $response = $self->handler->get($url);

        if(!$response->{'success'}) {
            BadResponseFromService->throw(service => ref $self.'::'.$service_name, url => $response->{'url'}, status => $response->{'status'}, reason => $response->{'reason'});
        }
        return $response->{'content'};
    }
}

1;
