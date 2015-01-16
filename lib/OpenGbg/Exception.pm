use 5.14.0;
use strict;
use warnings;

# Insired by Throwable::X
package OpenGbg::Exception {

    # VERSION
    # ABSTRACT: Exception role

    use Moose::Role;
    use Throwable::X::Types;

    use namespace::autoclean -except => 'meta';

    use Sub::Exporter -setup => {
        exports => { Payload => \'__payload' },
    };

    sub __payload {
        sub {
            'Role::HasPayload::Meta::Attribute::Payload';
        }
    }

    sub out {
        my $self = shift;
        say $self->message;
        say '';
        say $self->stack_trace;
        return $self;
    }
    sub fatal {
        die;
    }
    with(
        'Throwable',
        'StackTrace::Auto',
        'Role::HasPayload::Merged',
        'Role::HasMessage::Errf' => {
            default => sub { $_[0]->info },
            lazy => 1,
        }
    );
}

1;

__END__

=encoding utf-8

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

OpenGbg::Exception is the role all exceptions do.

=head1 ATTRIBUTES

=head2 info

An error message containing all information the thrown exception has about the error.

=head1 METHODS

=head2 out

Prints C<info> and a stack trace.

=head2 fatal

Dies.

    catch {
        my $error = $_;
        if($error->$_does('OpenGbg::Exception')) {
            $error->out->fatal;
        }
        else {
            die $_;
        }
    };

=cut
