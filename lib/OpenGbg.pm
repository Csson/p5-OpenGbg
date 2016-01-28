use 5.10.1;
use strict;
use warnings;

package OpenGbg;

# VERSION
# ABSTRACT: An interface to the Open Data API of Gothenburg

use OpenGbg::Elk;

use Config::Any;
use File::HomeDir;
use HTTP::Tiny;
use Path::Tiny;
use Types::Standard qw/HashRef Str/;
use Types::Path::Tiny qw/AbsFile/;
use namespace::autoclean;

use OpenGbg::Service::AirQuality;
use OpenGbg::Service::Bridge;
use OpenGbg::Service::StyrOchStall;
use OpenGbg::Service::TrafficCamera;

has config_file => (
    is => 'ro',
    isa => AbsFile,
    lazy => 1,
    builder => 1,
    init_arg => undef,
);
has config => (
    is => 'ro',
    isa => HashRef,
    lazy => 1,
    builder => 1,
    init_arg => undef,
);
has key => (
    is => 'ro',
    isa => Str,
    lazy => 1,
    builder => 1,
);
has ua => (
    is => 'ro',
    builder => 1,
    handles => ['get'],
);
has base => (
    is => 'ro',
    isa => Str,
    default => 'http://data.goteborg.se/',
);

my @services = qw/
    air_quality
    bridge
    styr_och_stall
    traffic_camera
/;
foreach my $service (@services) {
    has $service => (
        is => 'ro',
        lazy => 1,
        builder => 1,
    );
}

sub _build_config_file {
    my $home = File::HomeDir->my_home;
    my $conf_file = path($home)->child('.opengbg.ini');
}
sub _build_config {
    my $self = shift;

    my $cfg = Config::Any->load_files({
        use_ext => 1,
        files => [ $self->config_file ],
    });
    my $entry = shift @{ $cfg };
    my($filename, $config) = %{ $entry };
    return $config;
}
sub _build_key {
    return shift->config->{'API'}{'key'};
}
sub _build_ua {
    return HTTP::Tiny->new(agent => 'OpenGbg-Browser');
}

sub _build_air_quality {
    return OpenGbg::Service::AirQuality->new(handler => shift);
}
sub _build_bridge {
    return OpenGbg::Service::Bridge->new(handler => shift);
}
sub _build_styr_och_stall {
    return OpenGbg::Service::StyrOchStall->new(handler => shift);
}
sub _build_traffic_camera {
    return OpenGbg::Service::TrafficCamera->new(handler => shift);
}

__PACKAGE__->meta->make_immutable;

1;

__END__

=pod

=encoding utf-8

=head1 SYNOPSIS

    use OpenGbg;

    my $opengbg = OpenGbg->new(key => 'secret-api-key');

    $response = $opengbg->styr_och_stall->get_bike_stations;

    print $response->stations->get_by_index(0)->to_text;

=head1 DESCRIPTION

OpenGbg is a way to connect to and use the open data published by the city of L<Gothenburg|https://en.wikipedia.org/wiki/Gothenburg>.

The open data homepage is located at L<http://data.goteborg.se/>. All official documentation is in Swedish, but the license agreement is published
in English L<here|https://gbgdata.wordpress.com/goopen/>.

To use the API you need to get a free api key.

=head1 METHOD

=head2 new()

Takes an optional key-value pair, the key is C<key> and the value your api key, see L<authenticate|/"AUTHENTICATE">.

Returns a L<OpenGbg::Handler> object on which you then call the L<services|/"SERVICES">.

=head1 AUTHENTICATE

Once you have your api key you can use it in two different ways:

1. You can give it in the constructor:

    my $opengbg = OpenGbg->new(key => 'secret-api-key');

2. You can save it in a file named C<.opengbg.ini> in your homedir:

    [API]
    key = secret-api-key

=head1 SERVICES

The following services are currently implemented in this distribution:

L<AirQuality|OpenGbg::Service::AirQuality> - Data on air quality

L<Bridge|OpenGbg::Service::Bridge> - Data on the openness of Göta Älvbron

L<StyrOchStall|OpenGbg::Service::StyrOchStall> - Data on rent-a-bike stations

L<TrafficCamera|OpenGbg::Service::TrafficCamera> - Data on traffic cameras, and their images

=head1 NAMING

Most names related to the services are de-camelized, while others are lower-cased (no underscores). For example, the service 'GetBikeStations' is called like this:

    my $gbg = OpenGbg->new;
    my $stations = $gbg->get_bike_stations;

All calls to services are prefixed with 'get' even if the service isn't named that way. On the other hand, the 'service' suffix on some services are removed.

Date/time intervals are always called 'start' and 'end' (in the web services they are sometimes called 'start' and 'stop').

=head1 DISCLAIMER

This is not an official distribution.

=cut
