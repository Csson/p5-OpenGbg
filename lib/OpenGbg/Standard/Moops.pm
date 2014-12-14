use 5.20.0;

package OpenGbg::Standard::Moops {

    use base 'Moops';
    use List::AllUtils();
    use experimental();
    use OpenGbg::Types();
    use Eponymous::Hash();
    use List::Compare();
    use MooseX::SetOnce();
    use MooseX::AttributeShortcuts();

    sub import {
        my $class = shift;
        my %opts = @_;

        push @{ $opts{'imports'} ||= [] } => (
            'List::AllUtils'    => [qw/any none sum uniq/],
            'Eponymous::Hash'   => ['eh'],
            'String::Trim'      => ['trim'],
            'feature'           => [qw/:5.20/],
            'experimental'      => [qw/postderef/],
            'OpenGbg::Types'    => [{ replace => 1 }, '-types'],
            'List::Compare'     => [],
            'MooseX::SetOnce'   => [],
            'MooseX::AttributeShortcuts' => [],
        );

        $class->SUPER::import(%opts);
    }
}

1;
