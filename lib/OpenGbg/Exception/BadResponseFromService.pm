use OpenGbg::Standard::Moops;

class OpenGbg::Exception::BadResponseFromService with OpenGbg::Exception using Moose {

    use OpenGbg::Exception -all;

    has url => (
        is => 'ro',
        isa => Str,
        traits => [Payload],
    );
    has status => (
        is => 'ro',
        isa => Str,
        traits => [Payload],
    );
    has reason => (
        is => 'ro',
        isa => Str,
        traits => [Payload],
    );
    has service => (
        is => 'ro',
        isa => Str,
        traits => [Payload],
    );
    has info => (
        is => 'ro',
        isa => Str,
        lazy => 1,
        default => q{Bad response from %{service}s at %{url}s. Status: %{status}s Reason: %{reason}s},
    );
}

__END__

=encoding utf-8

=head1 NAME

OpenGbg::Exception::BadResponseFromService - When http fails

=head1 SYNOPSIS

    use Safe::Isa;
    use Try::Tiny:
    my $handler = OpenGbg->new(key => 'secret-api-key');

    my $response;
    try {
        $response = $handler->styr_och_stall->get_bike_stations;
    }
    catch {
        my $error = $_;
        if($error->$_does('OpenGbg::Exception')) {
            $error->out;
        }
        else {
            die $_;
        }
    };

=head1 DESCRIPTION

OpenGbg::Exception::BadResponseFromService is thrown when http calls to web services fail. It I<does> L<OpenGbg::Execption>.

=head1 ATTRIBUTES

=head2 service

The name of the service that was called (eg. C<OpenGbg::Service::StyrOchStall::get_bike_stations>).

=head2 url

String. The responding url.

=head2 status

String. The http error code.

=head2 reason

String. The http error message.

=head1 AUTHOR

Erik Carlsson E<lt>info@code301.comE<gt>

=head1 COPYRIGHT

Copyright 2014 - Erik Carlsson

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
