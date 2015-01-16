use 5.14.0;

package OpenGbg::Service::Bridge::GetIsCurrentlyOpen;

# VERSION
# ABSTRACT: Is the bridge currently open?

use OpenGbg::Types -types;
use XML::Rabbit::Root;
use DateTime::Format::HTTP;
use MooseX::AttributeShortcuts;
use Kavorka;

has xml => (
    is => 'ro',
    isa => Str,
    required => 1,
);

add_xpath_namespace 'x' => 'TK.DevServer.Services.BridgeService';

has_xpath_value _is_open => '/x:BridgeOpen/x:Value';

has is_open => (
    is => 'ro',
    isa => Bool,
    lazy => 1,
    builder => 1,
);

method _build_is_open {
    return $self->_is_open eq 'true';
}


finalize_class();

1;

__END__

=encoding utf-8

=head1 NAME

OpenGbg::Service::Bridge::GetIsCurrentlyOpen

=head1 SYNOPSIS

    my $bridge = OpenGbg->new->bridge;
    my $get_ico = $bridge->get_is_currently_open;

    print $get_ico->is_open ? 'It is open' : 'It is closed';

=head1 METHODS

=head2 is_open

Returns a true value if the bridge is open, false if not.

=head1 AUTHOR

Erik Carlsson E<lt>info@code301.comE<gt>

=head1 COPYRIGHT

Copyright 2014 - Erik Carlsson

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
