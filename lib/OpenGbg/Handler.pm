use OpenGbg::Standard::Moops;

class OpenGbg::Handler
using Moose {

    use Config::Any;
    use File::HomeDir;
    use HTTP::Tiny;
    use Path::Tiny;
    use OpenGbg::Service::AirQuality;
    use OpenGbg::Service::Bridge;
    use OpenGbg::Service::StyrOchStall;

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
    has air_quality => (
        is => 'ro',
        lazy => 1,
        builder => 1,
    );
    has bridge => (
        is => 'ro',
        lazy => 1,
        builder => 1,
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

    method _build_air_quality {
        return OpenGbg::Service::AirQuality->new(handler => $self);
    }
    method _build_bridge {
        return OpenGbg::Service::Bridge->new(handler => $self);
    }
    method _build_styr_och_stall {
        return OpenGbg::Service::StyrOchStall->new(handler => $self);
    }
}

__END__

=encoding utf-8

=head1 NAME

OpenGbg::Handler - The entry point to all OpenGbg services.

=head1 SYNOPSIS

    # $handler is a OpenGbg::Handler object
    my $handler = OpenGbg->new(key => 'secret-api-key');

    $response = $handler->styr_och_stall->get_bike_stations;

=head1 DESCRIPTION

OpenGbg::Handler is the class from where calls to all web services are made.

=head1 METHOD


=head2 air_quality()

Returns a L<OpenGbg::Service::AirQuality> object.


=head2 bridge()

Returns a L<OpenGbg::Service::Bridge> object.


=head2 styr_och_stall()

Returns a L<OpenGbg::Service::StyrOchStall> object.

=head1 AUTHOR

Erik Carlsson E<lt>info@code301.comE<gt>

=head1 COPYRIGHT

Copyright 2014 - Erik Carlsson

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
