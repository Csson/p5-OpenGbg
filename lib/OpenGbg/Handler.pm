use 5.10.1;
use strict;
use warnings;

# VERSION

package OpenGbg::Handler;

1;

__END__

=encoding utf-8

=head1 SYNOPSIS

    # $handler is a OpenGbg::Handler object
    my $handler = OpenGbg->new(key => 'secret-api-key');

    $response = $handler->styr_och_stall->get_bike_stations;

=head1 DESCRIPTION

OpenGbg::Handler is the class from where calls to all web services are made.

=head1 METHOD


=head2 air_quality()

Returns a L<OpenGbg::Service::AirQuality> object.


=head2 bridge()

Returns a L<OpenGbg::Service::Bridge> object.


=head2 styr_och_stall()

Returns a L<OpenGbg::Service::StyrOchStall> object.

=cut
