use OpenGbg::Standard::Moops;

class OpenGbg::Handler
 with OpenGbg::Service::StyrOchStall
using Moose {

    use File::HomeDir;
    use HTTP::Tiny;
    use Path::Tiny;

    has key => (
        is => 'ro',
        isa => Str,
        required => 1,
    );
    has ua => (
        is => 'ro',
        builder => 1,
        handles => ['get'],
    );
    has styr_och_stall => (
        is => 'ro',
        lazy => 1,
        builder => 1,
    );
    has base => (
        is => 'ro',
        isa => Str,
        default => 'http://data.goteborg.se/',
    );
    
    
    
    method _build_ua {
        return HTTP::Tiny->new(agent => 'OpenGbg-Browser');
    }

    method _build_styr_och_stall {
        return OpenGbg::Service::StyrOchStall->new(handler => $self);
    }
}
