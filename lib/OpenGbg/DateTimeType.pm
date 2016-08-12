package OpenGbg::DateTimeType;
our $VERSION = '0.1403';
use 5.10.0;
use strict;
use warnings;

use DateTime;
use Type::Library -base, -declare => qw/DateTime/;
use Type::Utils;

class_type(DateTime, { class => 'DateTime' });

1;
