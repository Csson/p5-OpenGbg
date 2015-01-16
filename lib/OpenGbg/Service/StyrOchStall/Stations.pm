use 5.14.0;
use strict;
use warnings;

package OpenGbg::Service::StyrOchStall::Stations;

# VERSION
# ABSTRACT: A list of bike stations

use XML::Rabbit;
use Kavorka;

has_xpath_object_list _stations => './x:Details' => 'OpenGbg::Service::StyrOchStall::Station',
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

=pod

=encoding utf-8

=head1 SYNOPSIS

    my $service = OpenGbg->new->styr_och_stall;
    my $response = $service->get_bike_stations;

    printf 'Time: %s', $response->timestamp;
    print $response->stations->get_by_index(5)->to_text;

=head1 METHODS

=head2 all

Returns an array of the L<OpenGbg::Service::StyrOchStall::Station> objects in the response.

=head2 count

Returns the number of L<Station|OpenGbg::Service::StyrOchStall::Station> objects in the response.

=head2 filter(sub { ... })

Allows filtering of the stations. Takes a sub routine reference, into which all L<Station|OpenGbg::Service::StyrOchStall::Station> objects are
passed one-by-one into C<$_>. Works like C<grep>.

=head2 find(sub { ... })

Just like C<filter>, except it returns the first station that matches.

=head2 get_by_index($index)

Returns the n:th L<OpenGbg::Service::StyrOchStall::Station> object in the response.

=head2 get_by_id($id)

Returns the station with id C<$id>.

=head2 map(sub { ... })

Like C<filter> it takes a sub routine reference and passes each L<Station|OpenGbg::Service::StyrOchStall::Station> as C<$_>. Eg, to get a total count of free bikes:

    use List::AllUtils 'sum';
    my $free_bikes_count = sum $response->stations->map( sub { $_->free_bikes });


=head2 sort(sub { ... })

Like C<filter> it takes a sub routine reference. It works just like C<sort> except the two L<Station|OpenGbg::Service::StyrOchStall::Station> objects to compare are passed as C<$_[0]> and C<$_[1]>

    my @most_bikes_first = $response->stations->sort( sub { $_[1]->free_bikes <=> $_[0]->free_bikes });

=cut
