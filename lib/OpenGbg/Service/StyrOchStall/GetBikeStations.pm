use 5.10.1;
use strict;
use warnings;

package OpenGbg::Service::StyrOchStall::GetBikeStations;

# VERSION
# ABSTRACT: Get data on all bike stations

use XML::Rabbit::Root;
use DateTime::Format::HTTP;
use MooseX::AttributeShortcuts;
use Types::Standard qw/Str/;
use Types::DateTime qw/DateTime/;

has xml => (
    is => 'ro',
    isa => Str,
    required => 1,
);

add_xpath_namespace 'x' => 'TK.DevServer.Services.RentalBikeService';

has_xpath_value _timestamp => '/x:RentalBikes/x:TimeStamp';

has_xpath_object stations => '/x:RentalBikes/x:Stations' => 'OpenGbg::Service::StyrOchStall::Stations';

has timestamp => (
    is => 'ro',
    isa => DateTime,
    lazy => 1,
    builder => 1,
);

sub _build_timestamp {
    return DateTime::Format::HTTP->parse_datetime(shift->_timestamp);
}

finalize_class();

1;

__END__

=pod

=encoding utf-8

=head1 SYNOPSIS

    my $service = OpenGbg->new->styr_och_stall;
    my $response = $service->get_bike_stations;

    printf 'Time: %s', $response->timestamp;
    print $response->stations->get_by_index(5)->to_text;

=head1 METHODS

=head2 timestamp

Returns the timestamp given in the response as a L<DateTime> object.

=head2 stations

Returns the list of stations in the response in a L<OpenGbg::Service::StyrOchStall::Stations> object.

=cut
