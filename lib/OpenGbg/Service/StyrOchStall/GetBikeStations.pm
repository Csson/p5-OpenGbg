use 5.14.0;

package OpenGbg::Service::StyrOchStall::GetBikeStations;

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

add_xpath_namespace 'x' => 'TK.DevServer.Services.RentalBikeService';

has_xpath_value _timestamp => '/x:RentalBikes/x:TimeStamp';

has_xpath_object stations => '/x:RentalBikes/x:Stations' => 'OpenGbg::Service::StyrOchStall::Stations';

has timestamp => (
    is => 'ro',
    isa => DateTime,
    lazy => 1,
    builder => 1,
);

method _build_timestamp {
    return DateTime::Format::HTTP->parse_datetime($self->_timestamp);
}

finalize_class();

1;

__END__

=encoding utf-8

=head1 NAME

OpenGbg::Service::StyrOchStall::GetBikeStations

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


=head1 AUTHOR

Erik Carlsson E<lt>info@code301.comE<gt>

=head1 COPYRIGHT

Copyright 2014 - Erik Carlsson

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
