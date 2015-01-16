use 5.14.0;
use strict;
use warnings;

package OpenGbg::Service::StyrOchStall::GetBikeStation;

# VERSION
# ABSTRACT: Get data about a bike station

use OpenGbg::Types -types;
use Kavorka;
use XML::Rabbit::Root;
use DateTime::Format::HTTP;
use MooseX::AttributeShortcuts;

has xml => (
    is => 'ro',
    isa => Str,
    required => 1,
);

add_xpath_namespace 'x' => 'TK.DevServer.Services.RentalBikeService';

has_xpath_value _timestamp => '/x:RentalBikes/x:TimeStamp';

has_xpath_object stations => '/x:RentalBikes/x:Stations' => 'OpenGbg::Service::StyrOchStall::Stations';

has timestamp => (
    is => 'ro',
    isa => DateTime,
    lazy => 1,
    builder => 1,
);

method _build_timestamp {
    return DateTime::Format::HTTP->parse_datetime($self->_timestamp);
}

method station {
    return $self->stations->get_by_index(0);
}

finalize_class();

1;

__END__

=encoding utf-8

=head1 NAME

OpenGbg::Service::StyrOchStall::GetBikeStation

=head1 SYNOPSIS

    my $service = OpenGbg->new->styr_och_stall;
    my $response = $service->get_bike_station(1);

    printf 'Time: %s', $response->timestamp;
    print $response->station->to_text;

=head1 METHODS

=head2 timestamp

Returns the timestamp given in the response as a L<DateTime> object.

=head2 station

Returns the L<OpenGbg::Service::StyrOchStall::Station> object given in the response.


=head1 AUTHOR

Erik Carlsson E<lt>info@code301.comE<gt>

=head1 COPYRIGHT

Copyright 2014 - Erik Carlsson

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
