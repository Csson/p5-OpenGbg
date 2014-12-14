use feature ':5.10';

package OpenGbg::Service::Getter {

	use Moose::Role;

	sub getter {
		my $self = shift;
		my $service_url = shift;
		$service_url = sprintf $service_url, $self->handler->key;
		say '>> '.$service_url;
		return $self->handler->get($self->handler->base.$self->service_base.$service_url);
	}
}

1;
