# NAME

OpenGbg - An interface to the Open Data API of Gothenburg

<div>
    <p><a style="float: left;" href="https://travis-ci.org/Csson/p5-OpenGbg"><img src="https://travis-ci.org/Csson/p5-OpenGbg.svg?branch=master">&nbsp;</a>
</div>

# SYNOPSIS

    use OpenGbg;

    my $opengbg = OpenGbg->new(key => 'secret-api-key');

    $service = $opengbg->styr_och_stall->get_bike_stations;

    print $service->stations->get(0)->to_text;

# DESCRIPTION

OpenGbg is a way to connect to and use the open data published by the city of [Gothenburg](https://en.wikipedia.org/wiki/Gothenburg).

The open data homepage is located at [http://data.goteborg.se/](http://data.goteborg.se/). All official documentation is in Swedish, but the license agreement is published
in English [here](https://gbgdata.wordpress.com/goopen/).

To use the API you need to get a free api key.

# METHOD

## new()

Takes an optional key-value pair, the key is `key` and the value your api key, see [authenticate](#authenticate).

Returns a [OpenGbg::Handler](https://metacpan.org/pod/OpenGbg::Handler) object. This object is not interesting in itself, see each service under [services](#services) for usage.

# AUTHENTICATE

Once you have your api key you can use it in two different ways:

1\. You can give it in the constructor:

    my $opengbg = OpenGbg->new(key => 'secret-api-key');

2\. You can save it in a file named `.opengbg.ini` in your homedir:

    [API]
    key = secret-api-key

# SERVICES

The following services are currently implemented in this distribution:

[StyrOchStall](https://metacpan.org/pod/OpenGbg::Service::StyrOchStall) - Data on rent-a-bike stations

# NAMING

All names related to the services are de-camelized. For example, the service 'GetBikeStations' is called like this:

    my $gbg = OpenGbg->new;
    my $stations = $gbg->get_bike_stations;

# BUGS & ISSUES

The repository and issue tracker is at: [https://github.com/Csson/p5-OpenGbg](https://github.com/Csson/p5-OpenGbg)

# DISCLAIMER

This is not an official distribution.

# AUTHOR

Erik Carlsson <info@code301.com>

# COPYRIGHT

Copyright 2014 - Erik Carlsson

# LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.
