use 5.10.0;
use strict;
use warnings;

package OpenGbg::Service::TrafficCamera::CameraDevice;

# ABSTRACT: Data about a traffic camera
# AUTHORITY
our $VERSION = '0.1403';

use XML::Rabbit;
use syntax 'qs';
use utf8;

has_xpath_value id => './x:ID';

has_xpath_value storage_duration_minutes => './x:StorageDurationMinutes';

has_xpath_value capture_interval_seconds => './x:CaptureIntervalSeconds';

has_xpath_value description => './x:Description';

has_xpath_value model => './x:Model';

sub to_text {
    my $self = shift;

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

=pod

=encoding utf-8

=head1 SYNOPSIS

    my $traffic_camera_service = OpenGbg->new->traffic_camera;
    my $get_traffic_cameras = $traffic_camera_service->get_traffic_cameras;

    my $camera_devices = $get_traffic_cameras->camera_devices;
    my $camera_device = $camera_devices->get_by_index(0)
    print $camera_device->to_text;


=head1 ATTRIBUTES

=head2 id

Integer. The traffic camera id.

=head2 description

String. The description/location of the traffic camera.

=head2 storage_duration_minutes

Integer. How long is the image saved. There is however currently no service to get any image but the latest.

=head2 capture_interval_seconds

Integer. How long between captures.

=head2 model

String. The brand and/or model of the traffic camera.


=head1 METHODS

=head2 to_text()

Returns a string with the traffic camera data in a table.

=cut
