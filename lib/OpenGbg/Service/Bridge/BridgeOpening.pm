use 5.14.0;

package OpenGbg::Service::Bridge::BridgeOpening;

use XML::Rabbit;
use DateTime;
use Kavorka;
use MooseX::AttributeShortcuts;
use OpenGbg::Types -types;

has_xpath_value _timestamp => './x:TimeStamp';

has_xpath_value _was_open => './x:Value';

has timestamp => (
    is => 'ro',
    isa => DateTime,
    lazy => 1,
    builder => 1,
);

has was_open => (
    is => 'ro',
    isa => Bool,
    lazy => 1,
    builder => 1,
);

method _build_timestamp {
    return DateTime::Format::HTTP->parse_datetime($self->_timestamp);
}
method _build_was_open {
    return $self->_was_open eq 'true';
}

finalize_class();

1;

__END__

=encoding utf-8

=head1 NAME

OpenGbg::Service::StyrOchStall::Station - A Styr och Ställ station

=head1 SYNOPSIS

    my $service = OpenGbg->new->styr_och_stall;
    my $station = $service->get_bike_stations->get_by_index(2);

    printf 'Free bikes:  %d', $station->free_bikes;

=head1 ATTRIBUTES

=head2 id

Integer. The station id.

=head2 label

String. The station/location name.

=head2 lat

=head2 long

Decimal degrees. The location of the station.

=head2 capacity

Integer. Maximum number of bikes.

=head2 free_bikes

Integer. Number of available bikes.

=head2 free_stands

Integer. Number of open stands.

=head2 state

String. Can be C<open>, C<closed>, C<maintenance> or C<construction>.

=head2 empty

Boolean. Returns true if there is no bike available.

=head2 full

Boolean. Returns true if there is no room to return a bike to.

=head1 METHODS

=head2 to_text()

Returns a string with the station data in a table.

=head1 AUTHOR

Erik Carlsson E<lt>info@code301.comE<gt>

=head1 COPYRIGHT

Copyright 2014 - Erik Carlsson

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
