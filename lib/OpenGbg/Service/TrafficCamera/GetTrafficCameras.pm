use 5.10.0;
use strict;
use warnings;

package OpenGbg::Service::TrafficCamera::GetTrafficCameras;

# ABSTRACT: Get a list of traffic cameras
# AUTHORITY
our $VERSION = '0.1402';

use XML::Rabbit::Root;
use Types::Standard qw/Str/;


has xml => (
    is => 'ro',
    isa => Str,
    required => 1,
);

add_xpath_namespace 'x' => 'TK.DevServer.Services.TrafficCameras';

has_xpath_object camera_devices => '/x:CameraDevices' => 'OpenGbg::Service::TrafficCamera::CameraDevices';

finalize_class();

1;

__END__

=encoding utf-8

=head1 SYNOPSIS

    my $traffic_camera_service = OpenGbg->new->traffic_camera;
    my $get_traffic_cameras = $traffic_camera_service->get_traffic_cameras;

    print $get_traffic_cameras->camera_devices->get_by_index(0)->to_text;

=head1 METHODS

=head2 camera_devices

Returns the list of traffic cameras in the response in a L<OpenGbg::Service::TrafficCamera::CameraDevices> object.

=cut
