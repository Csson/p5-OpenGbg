use OpenGbg::Standard::Imports;

# VERSION
# PODCLASSNAME
# ABSTRACT: Entry point to the Traffic Camera service

class OpenGbg::Service::TrafficCamera using Moose {

    use OpenGbg::Service::TrafficCamera::GetCameraImage;
    use OpenGbg::Service::TrafficCamera::GetTrafficCameras;
    with 'OpenGbg::Service::Getter';

    has handler => (
        is => 'ro',
        required => 1,
    );
    has service_base => (
        is => 'rw',
        isa => Str,
        default => 'TrafficCamera/v0.1/',
    );

    method get_camera_image($id) {
        my $url = "CameraImage/%s/$id?";
        my $response = $self->getter($url, 'get_camera_image');

        return OpenGbg::Service::TrafficCamera::GetCameraImage->new(image => $response);
    }

    method get_traffic_cameras {
        my $url = 'TrafficCameras/%s?';
        my $response = $self->getter($url, 'get_traffic_cameras');

        return OpenGbg::Service::TrafficCamera::GetTrafficCameras->new(xml => $response);
    }
}

__END__

=encoding utf-8

=head1 NAME

OpenGbg::Service::TrafficCamera - Data on traffic cameras and their images

=head1 SYNOPSIS

    my $traffic_camera_service = OpenGbg->new->traffic_camera;
    my $response = $traffic_camera_service->get_traffic_cameras;

    print $response->camera_devices->get_by_index(0)->to_text;

=head1 DESCRIPTION

Traffic cameras all around Gothenburg captures a lot of images (usually once per minute). This service gives information about the
cameras themselves, as well as a way to get the latest captured image from all cameras.

L<Official documentation|http://data.goteborg.se/Pages/Webservice.aspx?ID=15>

See L<OpenGbg> for general information.

=head1 METHODS

=head2 get_traffic_cameras

Get information on the traffic cameras.

Returns a L<GetTrafficCameras|OpenGbg::Service::TrafficCamera::GetTrafficCameras> object.


=head2 get_camera_image($camera_id)

Get the latest image from the camera with id C<$id>.

Returns a L<GetCameraImage|OpenGbg::Service::TrafficCamera::GetCameraImage> object.


=head1 AUTHOR

Erik Carlsson E<lt>info@code301.comE<gt>

=head1 COPYRIGHT

Copyright 2014 - Erik Carlsson

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
