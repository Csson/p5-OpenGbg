use feature ':5.20';

package OpenGbg::Service::StyrOchStall::GetBikeStations;

use OpenGbg::Types -types;
use XML::Rabbit::Root;
use DateTime::Format::HTTP;
use MooseX::AttributeShortcuts;
use experimental 'signatures';

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

sub _build_timestamp($self) {
    return DateTime::Format::HTTP->parse_datetime($self->_timestamp);
}

finalize_class();

1;
