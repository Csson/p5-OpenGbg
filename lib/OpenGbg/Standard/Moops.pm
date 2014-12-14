use 5.14.0;

package OpenGbg::Standard::Moops {

    use base 'Moops';
    use OpenGbg::Types();
    use MooseX::AttributeShortcuts();

    sub import {
        my $class = shift;
        my %opts = @_;

        push @{ $opts{'imports'} ||= [] } => (
            'feature'           => [qw/:5.14/],
            'OpenGbg::Types'    => [{ replace => 1 }, '-types'],
            'MooseX::AttributeShortcuts' => [],
        );

        $class->SUPER::import(%opts);
    }
}

1;
