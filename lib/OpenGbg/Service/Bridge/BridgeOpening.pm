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

OpenGbg::Service::Bridge::BridgeOpening - A change in status for Göta Älvbron

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

=head1 AUTHOR

Erik Carlsson E<lt>info@code301.comE<gt>

=head1 COPYRIGHT

Copyright 2014 - Erik Carlsson

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
