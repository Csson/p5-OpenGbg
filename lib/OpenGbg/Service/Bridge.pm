use OpenGbg::Standard::Imports;

# VERSION
# PODCLASSNAME
# ABSTRACT: Entry point to the Bridge service

class OpenGbg::Service::Bridge using Moose {

    use OpenGbg::Service::Bridge::GetIsCurrentlyOpen;
    use OpenGbg::Service::Bridge::GetOpenedStatus;

    with 'OpenGbg::Service::Getter';

    has handler => (
        is => 'ro',
        required => 1,
    );
    has service_base => (
        is => 'rw',
        isa => Str,
        default => 'BridgeService/v1.0/',
    );

    method get_is_currently_open {
        my $url = 'GetGABOpenedStatus/%s?';
        my $response = $self->getter($url, 'get_is_currently_open');

        return OpenGbg::Service::Bridge::GetIsCurrentlyOpen->new(xml => $response);
    }
    method get_opened_status($start, $end) {
        my $url = "GetGABOpenedStatus/%s/$start/$end?";
        my $response = $self->getter($url, 'get_opened_status');

        return OpenGbg::Service::Bridge::GetOpenedStatus->new(xml => $response);
    }

}

1;

__END__

=encoding utf-8

=head1 SYNOPSIS

    my $bridge = OpenGbg->new->bridge;
    my $response = $bridge->get_is_currently_open;

    print $response->is_open ? 'It is open' : 'It is closed';

=head1 DESCRIPTION

The Göta älvbron is a major bascule bridge in Gothenburg that opens more or less daily. This service publishes two methods with regards to its status.

L<Official documentation|http://data.goteborg.se/Pages/Webservice.aspx?ID=24>

See L<OpenGbg> for general information.


=head1 METHODS

=head2 get_is_currently_open

This method is for checking if the bridge is currently open.

Returns a L<GetIsCurrentlyOpen|OpenGbg::Service::Bridge::GetIsCurrentlyOpen> object.


=head2 get_opened_status($startdate, $enddate)

This method is for checking when it was opened in the past.

C<$startdate> and C<$enddate> are mandatory filtering arguments, both are expected to be in the iso-8601 representation: C<yyyy-mm-dd>. The ending date is not inclusive.

Returns a L<GetOpenedStatus|OpenGbg::Service::Bridge::GetOpenedStatus> object.

=cut
