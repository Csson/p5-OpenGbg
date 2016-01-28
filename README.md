# NAME

OpenGbg - An interface to the Open Data API of Gothenburg

![Requires Perl 5.14+](https://img.shields.io/badge/perl-5.14+-brightgreen.svg) [![Travis status](https://api.travis-ci.org/Csson/p5-OpenGbg.svg?branch=master)](https://travis-ci.org/Csson/p5-OpenGbg) 

# VERSION

Version 0.1302, released 2016-01-28.

# SYNOPSIS

    use OpenGbg;

    my $opengbg = OpenGbg->new(key => 'secret-api-key');

    $response = $opengbg->styr_och_stall->get_bike_stations;

    print $response->stations->get_by_index(0)->to_text;

# DESCRIPTION

OpenGbg is a way to connect to and use the open data published by the city of [Gothenburg](https://en.wikipedia.org/wiki/Gothenburg).

The open data homepage is located at [http://data.goteborg.se/](http://data.goteborg.se/). All official documentation is in Swedish, but the license agreement is published
in English [here](https://gbgdata.wordpress.com/goopen/).

To use the API you need to get a free api key.

# METHOD

## new()

Takes an optional key-value pair, the key is `key` and the value your api key, see [authenticate](#authenticate).

Returns a [OpenGbg::Handler](https://metacpan.org/pod/OpenGbg::Handler) object on which you then call the [services](#services).

# AUTHENTICATE

Once you have your api key you can use it in two different ways:

1\. You can give it in the constructor:

    my $opengbg = OpenGbg->new(key => 'secret-api-key');

2\. You can save it in a file named `.opengbg.ini` in your homedir:

    [API]
    key = secret-api-key

# SERVICES

The following services are currently implemented in this distribution:

[AirQuality](https://metacpan.org/pod/OpenGbg::Service::AirQuality) - Data on air quality

[Bridge](https://metacpan.org/pod/OpenGbg::Service::Bridge) - Data on the openness of Göta Älvbron

[StyrOchStall](https://metacpan.org/pod/OpenGbg::Service::StyrOchStall) - Data on rent-a-bike stations

[TrafficCamera](https://metacpan.org/pod/OpenGbg::Service::TrafficCamera) - Data on traffic cameras, and their images

# NAMING

Most names related to the services are de-camelized, while others are lower-cased (no underscores). For example, the service 'GetBikeStations' is called like this:

    my $gbg = OpenGbg->new;
    my $stations = $gbg->get_bike_stations;

All calls to services are prefixed with 'get' even if the service isn't named that way. On the other hand, the 'service' suffix on some services are removed.

Date/time intervals are always called 'start' and 'end' (in the web services they are sometimes called 'start' and 'stop').

# DISCLAIMER

This is not an official distribution.

# SOURCE

[https://github.com/Csson/p5-OpenGbg](https://github.com/Csson/p5-OpenGbg)

# HOMEPAGE

[https://metacpan.org/release/OpenGbg](https://metacpan.org/release/OpenGbg)

# AUTHOR

Erik Carlsson <info@code301.com>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2016 by Erik Carlsson.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
