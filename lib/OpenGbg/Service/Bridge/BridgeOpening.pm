use 5.10.0;
use strict;
use warnings;

package OpenGbg::Service::Bridge::BridgeOpening;

# ABSTRACT: A change in status for Göta Älvbron
# AUTHORITY
our $VERSION = '0.1402';

use XML::Rabbit;
use DateTime::Format::HTTP;
use MooseX::AttributeShortcuts;
use OpenGbg::DateTimeType qw/DateTime/;
use Types::Standard qw/Bool/;

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

sub _build_timestamp {
    return DateTime::Format::HTTP->parse_datetime(shift->_timestamp);
}
sub _build_was_open {
    return shift->_was_open eq 'true';
}

finalize_class();

1;

__END__

=pod

=encoding utf-8

=head1 SYNOPSIS

    my $bridge = OpenGbg->new->bridge;
    my $status = $bridge->get_opened_status->get_by_index(2);

    printf 'it was %s', $status->was_open ? 'open' : 'closed';

=head1 DESCRIPTIOn

Each C<BridgeOpening> object only knows if the bridge was opened or closed at that time. Usually, an 'open' BridgeOpening is followed a few minutes later by a 'closed' one.

=head1 ATTRIBUTES

=head2 timestamp

A L<DateTime> object.

The time the bridge was either open or closed.

=head2 was_open

Boolean. True if the bridge was open at C<timestamp>, false if not.

=cut
