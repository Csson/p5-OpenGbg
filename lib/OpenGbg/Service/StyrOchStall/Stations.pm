use feature ':5.20';

package OpenGbg::Service::StyrOchStall::Stations;

use XML::Rabbit;
use experimental 'signatures';

has_xpath_object_list _stations => './x:Details' => 'OpenGbg::Service::StyrOchStall::Station',
                                   handles => {
                                        all => 'elements',
                                        get => 'get',
                                        map => 'map',
                                        filter => 'grep',
                                        count => 'count',
                                        sort => 'sort',
                                   };

finalize_class();

1;
