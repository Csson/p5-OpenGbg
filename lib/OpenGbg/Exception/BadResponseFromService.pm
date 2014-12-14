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
    has service_name => (
        is => 'ro',
        isa => Str,
        traits => [Payload],
    );
    has info => (
        is => 'ro',
        isa => Str,
        lazy => 1,
        default => q{Bad response from %{service_name} at %{url}. Status: %{status} Reason: %{reason}},
    );
}
