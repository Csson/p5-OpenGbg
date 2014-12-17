use 5.14.0;

package OpenGbg::Service::TrafficCamera::CameraDevice;

use XML::Rabbit;
use syntax 'qs';
use Kavorka;

has_xpath_value id => './x:Id';

has_xpath_value storage_duration_minutes => './x:StorageDurationMinutes';

has_xpath_value capture_interval_seconds => './x:CaptureIntervalSeconds';

has_xpath_value description => './x:Description';

has_xpath_value model => './x:Model';

method to_text {
    return sprintf qs{
                Id:                    %s
                Description:           %s
                Storage duration (m):  %s
                Capture interval (s):  %s
                Model:                 %s
            },
            $self->id,
            $self->description,
            $self->storage_duration_minutes,
            $self->capture_interval_seconds,
            $self->model;

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
