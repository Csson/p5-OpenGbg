package OpenGbg;

use 5.14.0;

use OpenGbg::Handler;

sub new {
    shift;
    return OpenGbg::Handler->new(@_);
}

1;

__END__

=encoding utf-8

=head1 NAME

OpenGbg - An interface to the Open Data API of Gothenburg

=head1 SYNOPSIS

    use OpenGbg;

    my $opengbg = OpenGbg->new(key => 'secret-api-key')->handler;

    $service = $opengbg->styr_och_stall->get_bike_stations;

    print $service->stations->get(0)->to_text;

=head1 DESCRIPTION

OpenGbg is a way to connect to and use the open data published by the city of L<Gothenburg|https://en.wikipedia.org/wiki/Gothenburg>.

The open data homepage is located at L<http://data.goteborg.se/>. All documentation is in Swedish.

To use the API you need to get a free api key.

=head1 METHOD

=head2 new()

Only possible argument is C<key>, see L<authenticate|AUTHENTICATE>.

Returns a L<OpenGbg::Handler> object. This object is not interesting in itself, see each service under L<services|/"SERVICES"> for usage.


=head1 AUTHENTICATE

Once you have your api key you can use it in two different ways:

1. You can give it in the constructor:

    my $opengbg = OpenGbg->new(key => 'secret-api-key');

2. You can save it in i file named C<.opengbg.ini> in your homedir:

    [API]
    key = secret-api-key

=head1 SERVICES

The following services are currently implemented in this distribution:

L<StyrOchStall|OpenGbg::Service::StyrOchStall> - Data on rent-a-bike stations


=head1 BUGS & ISSUES

The repository and issue tracker is at: L<https://github.com/Csson/p5-OpenGbg>

=head1 DISCLAIMER

This is not an official distribution.

=head1 AUTHOR

Erik Carlsson E<lt>info@code301.comE<gt>

=head1 COPYRIGHT

Copyright 2014 - Erik Carlsson

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
