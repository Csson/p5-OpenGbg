use 5.14.0;

package OpenGbg::Service::Getter {

    use Moose::Role;
    use Kavorka;

    method getter($service_url) {
        $service_url = sprintf $service_url, $self->handler->key;
        my $url = $self->handler->base . $self->service_base . $service_url;

        return $self->handler->get($url);
    }
}

1;
