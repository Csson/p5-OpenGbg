use OpenGbg::Standard::Moops;

class OpenGbg::Handler
 with OpenGbg::Service::StyrOchStall
using Moose {

    use Config::Any;
    use File::HomeDir;
    use HTTP::Tiny;
    use Path::Tiny;

    has config_file => (
        is => 'ro',
        isa => AbsFile,
        lazy => 1,
        builder => 1,
        init_arg => undef,
    );
    has config => (
        is => 'ro',
        isa => HashRef,
        lazy => 1,
        builder => 1,
        init_arg => undef,
    );
    has key => (
        is => 'ro',
        isa => Str,
        lazy => 1,
        builder => 1,
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
    
    method _build_config_file {
        my $home = File::HomeDir->my_home;
        my $conf_file = path($home)->child('.opengbg.ini');
    }
    method _build_config {
        my $cfg = Config::Any->load_files({
            use_ext => 1,
            files => [ $self->config_file ],
        });
        my $entry = shift @{ $cfg };
        my($filename, $config) = %{ $entry };
        return $config;
    }
    method _build_key {
        return $self->config->{'API'}{'key'};
    }
    method _build_ua {
        return HTTP::Tiny->new(agent => 'OpenGbg-Browser');
    }

    method _build_styr_och_stall {
        return OpenGbg::Service::StyrOchStall->new(handler => $self);
    }
}
