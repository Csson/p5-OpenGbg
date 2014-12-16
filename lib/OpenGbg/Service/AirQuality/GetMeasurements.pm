use 5.14.0;

package OpenGbg::Service::AirQuality::GetMeasurements;

use OpenGbg::Types -types;
use XML::Rabbit::Root;
use DateTime::Format::HTTP;
use MooseX::AttributeShortcuts;
use Kavorka;

has xml => (
    is => 'ro',
    isa => Str,
    required => 1,
);

add_xpath_namespace 'x' => 'TK.DevServer.Services.AirQualityService';

has_xpath_object measurements => '/x:Measurements' => 'OpenGbg::Service::AirQuality::Measurements';

finalize_class();

1;

__END__

=encoding utf-8

=head1 NAME

OpenGbg::Service::AirQuality::GetMeasurements

=head1 SYNOPSIS

    my $service = OpenGbg->new->air_quality;
    my $response = $service->get_measurements(start => '2014-10-15', end => '2014-10-25');

    print $response->measurements->get_by_index(5)->to_text;

=head1 METHODS

=head2 measurements

Returns the list of measurements in the response in a L<OpenGbg::Service::AirQuality::Measurements> object.


=head1 AUTHOR

Erik Carlsson E<lt>info@code301.comE<gt>

=head1 COPYRIGHT

Copyright 2014 - Erik Carlsson

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
