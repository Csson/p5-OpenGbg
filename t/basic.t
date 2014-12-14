use strict;
use Test::More;
use OpenGbg;

my $open = OpenGbg->new;

is ref $open, 'OpenGbg::Handler', 'Right object';

done_testing;

