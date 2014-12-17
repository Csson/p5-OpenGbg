use 5.14.0;

package OpenGbg::Service::StyrOchStall::Station;

use XML::Rabbit;
use syntax 'qs';
use Kavorka;

has_xpath_value id => './x:Id';
has_xpath_value original_label => './x:Label';
has_xpath_value lat => './x:Lat';
has_xpath_value long => './x:Long';
has_xpath_value _capacity => './x:Capacity';
has_xpath_value _free_bikes => './x:FreeBikes';
has_xpath_value _free_stands => './x:FreeStands';
has_xpath_value state => './x:State';

method label {
    my $label = $self->original_label;
    $label =~ s{([\w']+)}{\u\L$1}g;
    return $label;
}

method capacity {
    return length $self->_capacity ? $self->_capacity : 0;
}
method free_bikes {
    return length $self->_free_bikes ? $self->_free_bikes : 0;
}
method free_stands {
    return length $self->_free_stands ? $self->_free_stands : 0;
}
method full {
    return $self->free_stands == 0;
}
method empty {
    return $self->free_bikes == 0;
}

method to_text {
    return sprintf qs{
                Id:             %s
                Label:          %s
                Latitude:       %s
                Longitude:      %s
                Capacity:       %2d
                Free bikes:     %2d
                Free stands:    %2d
                Empty:          %s
                Full:           %s
                State:          %s
            },
            $self->id,
            $self->label,
            $self->lat,
            $self->long,
            $self->capacity,
            $self->free_bikes,
            $self->free_stands,
            $self->empty,
            $self->full,
            $self->state;
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
