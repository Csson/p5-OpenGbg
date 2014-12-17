use strict;
use Test::More;
use File::HomeDir;
use Path::Tiny;
use OpenGbg;
use DateTime;


my $home = File::HomeDir->my_home;
my $has_conf_file = path($home)->child('.opengbg.ini')->exists;

if(!$has_conf_file) {
    plan skip_all => 'You need to get an api key from http://data.goteborg.se/ and put it in ~/.opengbg.ini. See documentation.';
}

my $open = OpenGbg->new;

main();

sub main {

    my $response;

    my $start = DateTime->from_epoch(epoch => time - 86400 * 14);
    $response = $open->bridge->get_opened_status($start->ymd, DateTime->now->ymd);

    is $response->bridge_openings->count >= 2, 1, 'We have bridge statuses';

}

done_testing;
