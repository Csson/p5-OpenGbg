use OpenGbg::Standard::Moops;

class OpenGbg::Service::StyrOchStall  using Moose {

    use OpenGbg::Service::StyrOchStall::GetBikeStations;
    with 'OpenGbg::Service::Getter';

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
        my $geo = '';
        if($lat && $long && $radius) {
            my %hash = ( eh $lat, $long, $radius );
            $geo = join '&' => map { "$_=$hash{ $_ }" } keys %hash;
        }

        my $url = "GetBikeStations/%s?$geo&format=xml";
        my $response = $self->getter($url);

        if(!$response->{'success'}) {
            die join ': ' => $response->{'status'}, $response->{'reason'};
        }

        return OpenGbg::Service::StyrOchStall::GetBikeStations->new(xml => $response->{'content'});
    }
}
