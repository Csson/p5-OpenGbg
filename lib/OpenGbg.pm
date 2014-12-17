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

=for html <p><a style="float: left;" href="https://travis-ci.org/Csson/p5-OpenGbg"><img src="https://travis-ci.org/Csson/p5-OpenGbg.svg?branch=master">&nbsp;</a>

=head1 SYNOPSIS

    use OpenGbg;

    my $opengbg = OpenGbg->new(key => 'secret-api-key');

    $response = $opengbg->styr_och_stall->get_bike_stations;

    print $response->stations->get_by_index(0)->to_text;

=head1 DESCRIPTION

OpenGbg is a way to connect to and use the open data published by the city of L<Gothenburg|https://en.wikipedia.org/wiki/Gothenburg>.

The open data homepage is located at L<http://data.goteborg.se/>. All official documentation is in Swedish, but the license agreement is published
in English L<here|https://gbgdata.wordpress.com/goopen/>.

To use the API you need to get a free api key.

=head1 METHOD

=head2 new()

Takes an optional key-value pair, the key is C<key> and the value your api key, see L<authenticate|/"AUTHENTICATE">.

Returns a L<OpenGbg::Handler> object on which you then call the L<services|/"SERVICES">.

=head1 AUTHENTICATE

Once you have your api key you can use it in two different ways:

1. You can give it in the constructor:

    my $opengbg = OpenGbg->new(key => 'secret-api-key');

2. You can save it in a file named C<.opengbg.ini> in your homedir:

    [API]
    key = secret-api-key

=head1 SERVICES

The following services are currently implemented in this distribution:

L<AirQuality|OpenGbg::Service::AirQuality> - Data on air quality

L<Bridge|OpenGbg::Service::Bridge> - Data on the openness of Göta Älvbron

L<StyrOchStall|OpenGbg::Service::StyrOchStall> - Data on rent-a-bike stations

=head1 NAMING

Most names related to the services are de-camelized, while others are lower-cased (no underscores). For example, the service 'GetBikeStations' is called like this:

    my $gbg = OpenGbg->new;
    my $stations = $gbg->get_bike_stations;

All calls to services are prefixed with 'get' even if the service isn't named that way. On the other hand, the 'service' suffix on some services are removed.

Date/time intervals are always called 'start' and 'end' (in the web services they are sometimes called 'start' and 'stop').

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
