use OpenGbg::Standard::Moops;

class OpenGbg::Service::StyrOchStall using Moose {

    has handler => (
        is => 'ro',
        required => 1,
    );
    has service_base => (
        is => 'rw',
        isa => Str,
        default => 'StyrOchStall/v0.1/',
    );
    
    

    method get_bike_stations(:$lat = undef, :$long = undef, :$radius = undef) {
        my $geo;
        if($lat && $long && $radius) {
            my %hash = ( eh $lat, $long, $radius );
            $geo = join '&' => map { $_ => $hash{ $_ } } keys %hash;
        }

        return $self->handler->get->($self->handler->base.$self->service_base.'GetBikeStations/'.$self->handler->key."?$geo&format=xml");
    }
}
