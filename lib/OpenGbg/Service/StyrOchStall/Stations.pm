use 5.14.0;

package OpenGbg::Service::StyrOchStall::Stations;

use XML::Rabbit;
use experimental 'signatures';

has_xpath_object_list _stations => './x:Details' => 'OpenGbg::Service::StyrOchStall::Station',
                                   handles => {
                                        all => 'elements',
                                        count => 'count',
                                        filter => 'grep',
                                        get => 'get',
                                        map => 'map',
                                        sort => 'sort',
                                   };

finalize_class();

1;

__END__

=encoding utf-8

=head1 NAME

OpenGbg::Service::StyrOchStall::Stations - A list of Styr och Ställ stations

=head1 SYNOPSIS

    my $styr_och_stall = OpenGbg->new->styr_och_stall;
    my $service = $styr_och_stall->get_bike_stations;

    printf 'Time: %s', $service->timestamp;
    print $service->stations->get(5)->to_text;

=head1 METHODS

=head2 all

Returns an array of the L<OpenGbg::Service::StyrOchStall::Station> objects in the response.

=head2 count

Returns the number of L<Station|OpenGbg::Service::StyrOchStall::Station> objects in the response.

=head2 filter(sub { ... })

Allows filtering of the stations. Takes a sub routine reference, into which all L<Station|OpenGbg::Service::StyrOchStall::Station> objects are
passed one-by-one into C<$_>. Works like C<grep>.

=head2 get($index)

Gets the n:th L<OpenGbg::Service::StyrOchStall::Station> object in the response. Do note that this is B<not> the station id. For that you
would use:

    my $wanted_station = $stations->filter(sub { $_->id == $wanted_id });

=head2 map(sub { ... })

Like C<filter> it takes a sub routine reference and passes each L<Station|OpenGbg::Service::StyrOchStall::Station> as C<$_>. Eg, to get a total count of free bikes:

    use List::AllUtils 'sum';
    my $free_bikes_count = sum $service->stations->map( sub { $_->free_bikes });


=head2 sort(sub { ... })

Like C<filter> it takes a sub routine reference. It works just like C<sort> except the two L<Station|OpenGbg::Service::StyrOchStall::Station> objects to compare are passed as C<$_[0]> and C<$_[1]>


=head1 AUTHOR

Erik Carlsson E<lt>info@code301.comE<gt>

=head1 COPYRIGHT

Copyright 2014 - Erik Carlsson

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
