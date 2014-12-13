package OpenGbg;

use 5.20.0;
use Moose;
use Kavorka 'around';
use OpenGbg::Handler;

around BUILDARGS($orig: $class, @args) {
    return OpenGbg::Handler->new(@args);
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