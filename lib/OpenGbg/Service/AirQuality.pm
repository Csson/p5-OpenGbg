use OpenGbg::Standard::Moops;

class OpenGbg::Service::AirQuality using Moose {

    use OpenGbg::Service::AirQuality::GetLatestMeasurement;
    use OpenGbg::Service::AirQuality::GetMeasurements;

    with 'OpenGbg::Service::Getter';

    has handler => (
        is => 'ro',
        required => 1,
    );
    has service_base => (
        is => 'rw',
        isa => Str,
        default => 'AirQualityService/v1.0/',
    );

    method get_latest_measurement {
        my $url = 'LatestMeasurement/%s?';
        my $response = $self->getter($url, 'latest_measurement');

        return OpenGbg::Service::AirQuality::GetLatestMeasurement->new(xml => $response);
    }
    method get_measurements(:$start, :$end) {
        my %dates = (startdate => $start, enddate => $end);
        my $dates = join '&' => map { "$_=$dates{ $_ }"} keys %dates;

        my $url = "Measurements/%s?$dates&";
        my $response = $self->getter($url, 'measurements');

        return OpenGbg::Service::AirQuality::GetMeasurements->new(xml => $response);
    }

}

__END__

=encoding utf-8

=head1 NAME

OpenGbg::Service::AirQuality - Data on air quality

=head1 SYNOPSIS

    my $service = OpenGbg->new->air_quality;
    my $response = $service->get_latest_measurement;

    print $response->measurement->to_text;

=head1 DESCRIPTION

Gothenburg publishes hourly readings on weather and air quality. The service publishes two methods to get this data.

L<Official documentation|http://data.goteborg.se/Pages/Webservice.aspx?ID=13>

See L<OpenGbg> for general information.


=head1 METHODS

=head2 get_latest_measurement

Returns a L<GetLatestMeasurement|OpenGbg::Service::AirQuality::GetLatestMeasurement> object.


=head2 get_measurements(%dates)

C<%dates> is a hash that filters returned measurements. Its keys are C<start> and C<end>, both are expected to be in the iso-8601 representation: C<yyyy-mm-dd>.

Given C<start =E<gt> '2014-10-15', end =E<gt> '2014-10-25'> then all measurements between 2014-10-15 00:00:00 and 2014-10-25 00:00:00 will be returned.

Returns a L<GetMeasurements|OpenGbg::Service::AirQuality::GetMeasurements> object.


=head1 AUTHOR

Erik Carlsson E<lt>info@code301.comE<gt>

=head1 COPYRIGHT

Copyright 2014 - Erik Carlsson

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
