use 5.10.1;
use strict;
use warnings;

package OpenGbg::Exceptions;

# VERSION

use Throwable::SugarFactory;

exception BadResponseFromService
       => 'Failed to get response from service'
       => has => [service => (is => 'ro')]
       => has => [url => (is => 'ro')]
       => has => [status => (is => 'ro')]
       => has => [reason => (is => 'ro')]
       ;

1;
