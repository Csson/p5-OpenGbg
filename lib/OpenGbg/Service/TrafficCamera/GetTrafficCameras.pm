use 5.14.0;

package OpenGbg::Service::TrafficCamera::GetTrafficCameras;

use OpenGbg::Types -types;
use XML::Rabbit::Root;
use MooseX::AttributeShortcuts;
use Kavorka;

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

=head1 NAME

OpenGbg::Service::TrafficCamera::GetTrafficCameras

=head1 SYNOPSIS

    my $traffic_camera_service = OpenGbg->new->traffic_camera;
    my $get_traffic_cameras = $traffic_camera_service->get_traffic_cameras;

    print $get_traffic_cameras->camera_devices->get_by_index(0)->to_text;

=head1 METHODS

=head2 camera_devices

Returns the list of traffic cameras in the response in a L<OpenGbg::Service::TrafficCamera::CameraDevices> object.

=head1 AUTHOR

Erik Carlsson E<lt>info@code301.comE<gt>

=head1 COPYRIGHT

Copyright 2014 - Erik Carlsson

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
