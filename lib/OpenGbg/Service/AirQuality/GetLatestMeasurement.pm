use 5.10.0;
use strict;
use warnings;

package OpenGbg::Service::AirQuality::GetLatestMeasurement;

# ABSTRACT: Get the latest air quality measurement
# AUTHORITY
our $VERSION = '0.1401';

use XML::Rabbit::Root;
use Types::Standard qw/Str/;

has xml => (
    is => 'ro',
    isa => Str,
    required => 1,
);

add_xpath_namespace 'x' => 'TK.DevServer.Services.AirQualityService';

has_xpath_object measurement => '/x:Measurement' => 'OpenGbg::Service::AirQuality::Measurement',
    handles => [qw//];

finalize_class();

1;

__END__

=pod

=encoding utf-8

=head1 SYNOPSIS

    my $service = OpenGbg->new->air_quality;
    my $response = $service->get_latest_measurement;

    print $response->measurement->to_text;

=head1 METHODS

=head2 measurement

Returns the L<OpenGbg::Service::AirQuality::Measurement> object given in the response  (usually less than an hour old).

=cut
