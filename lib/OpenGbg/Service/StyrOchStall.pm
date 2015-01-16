use OpenGbg::Standard::Imports;

# VERSION
# PODCLASSNAME
# ABSTRACT: Entry point to the StyrOchStall bike rental service

class OpenGbg::Service::StyrOchStall using Moose {

    use aliased 'OpenGbg::Service::StyrOchStall::GetBikeStation';
    use aliased 'OpenGbg::Service::StyrOchStall::GetBikeStations';
    use aliased 'OpenGbg::Exception::BadResponseFromService';
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

    method get_bike_station($id) {
        my $url = "GetBikeStation/$id/%s?";
        my $response = $self->getter($url, 'get_bike_station');

        return GetBikeStation->new(xml => $response);
    }

    method get_bike_stations(:$lat = undef, :$long = undef, :$radius = undef) {
        my $geo = '';
        if($lat && $long && $radius) {
            my %hash = ( latitude => $lat, longitude => $long, radius => $radius );
            $geo = join '&' => map { "$_=$hash{ $_ }" } keys %hash;
        }

        my $url = "GetBikeStations/%s?$geo&";
        my $response = $self->getter($url, 'get_bike_stations');

        return GetBikeStations->new(xml => $response);
    }
}

__END__

=encoding utf-8

=head1 NAME

OpenGbg::Service::StyrOchStall - Data on rent-a-bike stations

=head1 SYNOPSIS

    my $service = OpenGbg->new->styr_och_stall;
    my $response = $service->get_bike_stations;

    print $response->stations->get_by_index(0)->to_text;

=head1 DESCRIPTION

Styr och ställ is Gothenburg's bike share program. This service has a couple of methods to get data about the bike stations.

L<Official documentation|http://data.goteborg.se/Pages/Webservice.aspx?ID=10>

See L<OpenGbg> for general information.

=head1 METHODS

=head2 get_bike_station($id)

C<$id> is the station id for the station you want to get information about. You'll need to first have fetched the stations with L<get_bike_stations|/"get_bike_stations(%geography)"> to get the ids.

Returns a L<GetBikeStation|OpenGbg::Service::StyrOchStall::GetBikeStation> object.


=head2 get_bike_stations(%geography)

C<%geography> is an optional hash used to limit returned stations to a geographical area.
Its keys are C<lat> and C<long>, and optionally C<radius> (in metres).

If C<%geography> is absent no geographic filtering is done.

Returns a L<GetBikeStations|OpenGbg::Service::StyrOchStall::GetBikeStations> object.

=head1 EXCEPTIONS

If the http call to the web service fails, a L<BadResponseFromService|OpenGbg::Exception::BadResponseFromService> exception is thrown. Use L<Try::Tiny> to catch.

=head1 AUTHOR

Erik Carlsson E<lt>info@code301.comE<gt>

=head1 COPYRIGHT

Copyright 2014 - Erik Carlsson

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
