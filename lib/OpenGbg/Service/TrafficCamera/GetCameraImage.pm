use 5.10.0;
use strict;
use warnings;

package OpenGbg::Service::TrafficCamera::GetCameraImage;

# ABSTRACT: Get the current image from a traffic camera
# AUTHORITY
our $VERSION = '0.1403';

use OpenGbg::Elk;
use namespace::autoclean;
use Types::Standard qw/Int/;
use OpenGbg::DateTimeType qw/DateTime/;

use DateTime;

has image => (
    is => 'ro',
);
has image_size => (
    is => 'ro',
    isa => Int,
    lazy => 1,
    builder => 1,
);
has timestamp => (
    is => 'ro',
    isa => DateTime,
    lazy => 1,
    builder => 1,
);

sub _build_image_size {
    return length shift->image;
}

sub _build_timestamp {
    my $datetime = DateTime::->now->truncate(to => 'minute')->set_time_zone('Europe/Stockholm');
}

__PACKAGE__->meta->make_immutable;

1;

__END__

=pod

=encoding utf-8

=head1 SYNOPSIS

    use Path::Tiny;

    my $camera_id = 30;
    my $traffic_camera_service = OpenGbg->new->traffic_camera;
    my $get_camera_image = $traffic_camera_service->get_camera_image($camera_id);

    say sprintf '%s bytes', $get_camera_image->size;
    path(sprintf 'image-%s-%s.jpg', time, $camera_id)->spew($get_camera_image->image);

=head1 ATTRIBUTES

=head2 image_size

Integer. The image size in bytes. Sometimes cameras are out-of-order, and returns a dummy image. These are at the time of writing less than 10kb, and is therefore useful to filter on (if these images are unwanted).

=head2 timestamp

A L<DateTime> object, rounded down to the closest minute. The timestamp of the image is not given in the response from the web service. This DateTime object is created as a convenience.

=cut
