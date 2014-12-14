package OpenGbg;

use 5.20.0;
use Moose;
use Kavorka qw/around after/;
use OpenGbg::Handler;

has handler => (
    is => 'ro',
);

around BUILDARGS($orig: $class, @args) {
    $class->$orig(handler => OpenGbg::Handler->new(@args));
}

1;

__END__

=encoding utf-8

=head1 NAME

OpenGbg - Short intro

=head1 SYNOPSIS

  use OpenGbg;

=head1 DESCRIPTION

OpenGbg is ...

=head1 SEE ALSO

=cut