use strict;
use Test::More;
use File::HomeDir;
use Path::Tiny;
use OpenGbg;


my $home = File::HomeDir->my_home;
my $has_conf_file = path($home)->child('.opengbg.ini')->exists;

if(!$has_conf_file) {
    plan skip_all => 'You need to get an api key from http://data.goteborg.se/ and put it in ~/.opengbg.ini. See documentation.';
}

my $open = OpenGbg->new;

is ref $open, 'OpenGbg', 'Right object';

is $open->styr_och_stall->get_bike_station(1)->station->label, 'Lilla Bommen', 'Found Lilla Bommen';

done_testing;

