use 5.14.0;

package OpenGbg::Service::AirQuality::Measurements;

use XML::Rabbit;
use Kavorka;

has_xpath_object_list _measurements => './x:Measurement' => 'OpenGbg::Service::AirQuality::Measurement',
                                   handles => {
                                        all => 'elements',
                                        count => 'count',
                                        filter => 'grep',
                                        find => 'first',
                                        get_by_index => 'get',
                                        map => 'map',
                                        sort => 'sort',
                                   };

finalize_class();

1;

__END__

=encoding utf-8

=head1 NAME

OpenGbg::Service::AirQuality::Measurements - A list of air quality measurements

=head1 SYNOPSIS

    my $aq = OpenGbg->new->air_quality;
    my $response = $aq->get_measurements(start => '2014-10-15', end => '2014-10-25');

    print $response->measurements->get_by_index(3)->to_text;

=head1 METHODS

=head2 all

Returns an array of the L<OpenGbg::Service::AirQuality::Measurement> objects in the response.

=head2 count

Returns the number of L<Measurement|OpenGbg::Service::AirQuality::Measurement> objects in the response.

=head2 filter(sub { ... })

Allows filtering of the measurements. Takes a sub routine reference, into which all L<Measurement|OpenGbg::Service::AirQuality::Measurement> objects are
passed one-by-one into C<$_>. Works like C<grep>.

=head2 find(sub { ... })

Just like C<filter>, except it returns the first measurement that matches.

=head2 get_by_index($index)

Returns the n:th L<OpenGbg::Service::AirQuality::Measurement> object in the response.

=head2 map(sub { ... })

Like C<filter> it takes a sub routine reference and passes each L<Measurement|OpenGbg::Service::AirQuality::Measurement> as C<$_>.
Eg, to get the total solar insolation:

    use List::AllUtils 'sum';
    my $total_solar_insolation_per_m2 = sum $response->measurements->map( sub { $_->solar_insolation });


=head2 sort(sub { ... })

Like C<filter> it takes a sub routine reference. It works just like C<sort> except the two L<Measurement|OpenGbg::Service::AirQuality::Measurement> objects to compare are passed as C<$_[0]> and C<$_[1]>

    my @hottest_hours_first = $response->measurements->sort( sub { $_[1]->temperature <=> $_[0]->temperature });

=head1 AUTHOR

Erik Carlsson E<lt>info@code301.comE<gt>

=head1 COPYRIGHT

Copyright 2014 - Erik Carlsson

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
