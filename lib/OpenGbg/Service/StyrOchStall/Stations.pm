use 5.10.1;
use strict;
use warnings;

package OpenGbg::Service::StyrOchStall::Stations;

# VERSION
# ABSTRACT: A list of bike stations

use XML::Rabbit;

#has_xpath_object_list _stations => './x:Details' => 'OpenGbg::Service::StyrOchStall::Station',
#                                   handles => {
#                                        all => 'elements',
#                                        count => 'count',
#                                        filter => 'grep',
#                                        find => 'first',
#                                        get_by_index => 'get',
#                                        map => 'map',
#                                        sort => 'sort',
#                                   };
#
#sub get_by_id {
#    my $self = shift;
#    my $id = shift;
#
#    return $self->find(sub { $_->id == $id });
#}
#
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


=cut
