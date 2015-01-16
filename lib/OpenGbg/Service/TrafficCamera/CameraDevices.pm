use 5.14.0;

package OpenGbg::Service::TrafficCamera::CameraDevices;

# VERSION
# ABSTRACT: A list of traffic cameras

use XML::Rabbit;
use Kavorka;

has_xpath_object_list _camera_devices => './x:CameraDevice' => 'OpenGbg::Service::TrafficCamera::CameraDevice',
                                   handles => {
                                        all => 'elements',
                                        count => 'count',
                                        filter => 'grep',
                                        find => 'first',
                                        get_by_index => 'get',
                                        map => 'map',
                                        sort => 'sort',
                                   };

method get_by_id($id) {
    return $self->find(sub { $_ == $id });
}

finalize_class();

1;

__END__

=encoding utf-8

=head1 NAME

OpenGbg::Service::TrafficCamera::CameraDevices - A list of Styr och Ställ stations

=head1 SYNOPSIS

    my $traffic_camera_service = OpenGbg->new->traffic_camera;
    my $get_traffic_cameras = $traffic_camera_service->get_traffic_cameras;

    my $camera_devices = $get_traffic_cameras->camera_devices;
    print $camera_devices->get_by_index(0)->to_text;

=head1 METHODS

=head2 all

Returns an array of all L<OpenGbg::Service::TrafficCamera::CameraDevice> objects in the response.

=head2 count

Returns the number of L<CameraDevice|OpenGbg::Service::TrafficCamera::CameraDevice> objects in the response.

=head2 filter(sub { ... })

Allows filtering of the traffic cameras. Takes a sub routine reference, into which all L<CameraDevice|OpenGbg::Service::TrafficCamera::CameraDevice> objects are
passed one-by-one into C<$_>. Works like C<grep>.

=head2 find(sub { ... })

Just like C<filter>, except it returns the first traffic camera that matches.

=head2 get_by_index($index)

Returns the n:th L<OpenGbg::Service::TrafficCamera::CameraDevice> object in the response.

=head2 get_by_id($id)

Returns the traffic camera with id C<$id>.

=head2 map(sub { ... })

Like C<filter> it takes a sub routine reference and passes each L<CameraDevice|OpenGbg::Service::TrafficCamera::CameraDevice> as C<$_>. Eg, to get a total count of free bikes:

=head2 sort(sub { ... })

Like C<filter> it takes a sub routine reference. It works just like C<sort> except the two L<CameraDevice|OpenGbg::Service::TrafficCamera::CameraDevice> objects to compare are passed as C<$_[0]> and C<$_[1]>

=head1 AUTHOR

Erik Carlsson E<lt>info@code301.comE<gt>

=head1 COPYRIGHT

Copyright 2014 - Erik Carlsson

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
