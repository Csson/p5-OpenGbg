use OpenGbg::Standard::Moops;

class OpenGbg::Service::Bridge using Moose {

    use OpenGbg::Service::Bridge::GetIsCurrentlyOpen;
    use OpenGbg::Service::Bridge::GetOpenedStatus;

    with 'OpenGbg::Service::Getter';

    has handler => (
        is => 'ro',
        required => 1,
    );
    has service_base => (
        is => 'rw',
        isa => Str,
        default => 'BridgeService/v1.0/',
    );

    method get_is_currently_open {
        my $url = 'GetGABOpenedStatus/%s?';
        my $response = $self->getter($url, 'get_is_currently_open');

        return OpenGbg::Service::Bridge::GetIsCurrentlyOpen->new(xml => $response);
    }
    method get_opened_status($start, $end) {
        my $url = "GetGABOpenedStatus/%s/$start/$end/?";
        my $response = $self->getter($url, 'measurements');

        return OpenGbg::Service::Bridge::GetOpenedStatus->new(xml => $response);
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

Given C<start =E<gt> '2014-10-15', end =E<gt> '2014-10-25' then all measurements between 2014-10-15 00:00:00 and 2014-10-25 00:00:00 will be returned.

Returns a L<GetMeasurements|OpenGbg::Service::AirQuality::GetMeasurements> object.


=head1 AUTHOR

Erik Carlsson E<lt>info@code301.comE<gt>

=head1 COPYRIGHT

Copyright 2014 - Erik Carlsson

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
