use 5.10.0;
use strict;
use warnings;

package OpenGbg::Exceptions;

# AUTHORITY
our $VERSION = '0.1405';

use Throwable::SugarFactory;

exception BadResponseFromService
       => 'Failed to get response from service'
       => has => [service => (is => 'ro')]
       => has => [url => (is => 'ro')]
       => has => [status => (is => 'ro')]
       => has => [reason => (is => 'ro')]
       ;

1;
