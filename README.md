# NAME

OpenGbg - An interface to the Open Data API of Gothenburg

<div>
    <p>
    <img src="https://img.shields.io/badge/perl-5.10+-blue.svg" alt="Requires Perl 5.10+" />
    <a href="https://travis-ci.org/Csson/p5-OpenGbg"><img src="https://api.travis-ci.org/Csson/p5-OpenGbg.svg?branch=master" alt="Travis status" /></a>
    <a href="http://cpants.cpanauthors.org/release/CSSON/OpenGbg-0.1404"><img src="http://badgedepot.code301.com/badge/kwalitee/CSSON/OpenGbg/0.1404" alt="Distribution kwalitee" /></a>
    <a href="http://matrix.cpantesters.org/?dist=OpenGbg%200.1404"><img src="http://badgedepot.code301.com/badge/cpantesters/OpenGbg/0.1404" alt="CPAN Testers result" /></a>
    <img src="https://img.shields.io/badge/coverage-75.9%-orange.svg" alt="coverage 75.9%" />
    </p>
</div>

# VERSION

Version 0.1404, released 2018-05-19.

# SYNOPSIS

    use OpenGbg;

    my $opengbg = OpenGbg->new(key => 'secret-api-key');

    $stations = $opengbg->styr_och_stall->get_bike_stations;

    print $stations->get_by_index(0)->to_text;

# DESCRIPTION

OpenGbg is a way to connect to and use the open data published by the city of [Gothenburg](https://en.wikipedia.org/wiki/Gothenburg).

The open data homepage is located at [http://data.goteborg.se/](http://data.goteborg.se/). All official documentation is in Swedish, but the license agreement is published
in English [here](http://www25.goteborg.se/psidata/DownloadHandler.ashx?id=7092f661-00c2-4b36-a613-98ca034e2e54&t=h).

To use the API you need to sign up for a free api key.

## Authenticate

Once you have your api key you can use it to authenticate in two different ways:

1\. You can give it in the constructor:

    my $opengbg = OpenGbg->new(key => 'secret-api-key');

2\. You can save it in a file named `.opengbg.ini` in your homedir (recommended):

    [API]
    key = secret-api-key

# METHODS

## new()

Takes an optional key-value pair, the key is `key` and the value your api key, see [authenticate](#authenticate).

    my $gbg = OpenGbg->new(key => 'secret-api-key');

    # or, if the api key is set in C<.opengbg.ini>:

    my $gbg = OpenGbg->new;

# SERVICES

The following services are currently implemented in this distribution:

[$gbg->air\_quality](https://metacpan.org/pod/OpenGbg::Service::AirQuality) - Data on air quality

[$gbg->bridge](https://metacpan.org/pod/OpenGbg::Service::Bridge) - Data on the openness of Göta Älvbron

[$gbg->styr\_och\_stall](https://metacpan.org/pod/OpenGbg::Service::StyrOchStall) - Data on rent-a-bike stations (deprecated)

[$gbg->traffic\_camera](https://metacpan.org/pod/OpenGbg::Service::TrafficCamera) - Data on traffic cameras, and their images

## Naming

Most names related to the services are de-camelized, while others are lower-cased (no underscores). For example, the service 'GetBikeStations' is called like this:

    my $gbg = OpenGbg->new;
    my $stations = $gbg->styr_och_stall->get_bike_stations;

All calls to services are prefixed with 'get' even if the service isn't named that way. On the other hand, the 'service' suffix on some services are removed.

Date/time intervals are always called `start` and `end` (in the web services they are sometimes called 'start' and 'stop').

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
