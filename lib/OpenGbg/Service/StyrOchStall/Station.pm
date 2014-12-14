use 5.14.0;

package OpenGbg::Service::StyrOchStall::Station;

use XML::Rabbit;
use syntax 'qs';
use Kavorka;

has_xpath_value id => './x:Id';
has_xpath_value original_label => './x:Label';
has_xpath_value lat => './x:Lat';
has_xpath_value long => './x:Long';
has_xpath_value _capacity => './x:Capacity';
has_xpath_value _free_bikes => './x:FreeBikes';
has_xpath_value _free_stands => './x:FreeStands';
has_xpath_value state => './x:State';

method label {
    my $label = $self->original_label;
    $label =~ s{([\w']+)}{\u\L$1}g;
    return $label;
}

method capacity {
    return length $self->_capacity ? $self->_capacity : 0;
}
method free_bikes {
    return length $self->_free_bikes ? $self->_free_bikes : 0;
}
method free_stands {
    return length $self->_free_stands ? $self->_free_stands : 0;
}
method full {
    return $self->free_stands == 0;
}
method empty {
    return $self->free_bikes == 0;
}

method to_text {
    return sprintf qs{
                Id:             %s
                Label:          %s
                Lat:            %s
                Long:           %s
                Capacity:       %2d
                Free bikes:     %2d
                Free stands:    %2d
                State:          %s
            },
            $self->id,
            $self->label,
            $self->lat,
            $self->long,
            $self->capacity,
            $self->free_bikes,
            $self->free_stands,
            $self->state;
}

finalize_class();

1;
