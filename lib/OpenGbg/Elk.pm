use 5.10.1;
use strict;
use warnings;

package OpenGbg::Elk;

# VERSION

use Moose();
use MooseX::AttributeShortcuts();
use Types::Standard();
use Types::Path::Tiny();
use Types::DateTime();
use Moose::Exporter;

Moose::Exporter->setup_import_methods(also => ['Moose']);

sub init_meta {
    my $class = shift;

    my %params = @_;
    my $for_class = $params{'for_class'};
    Moose->init_meta(@_);
    MooseX::AttributeShortcuts->init_meta(for_class => $for_class);
    Types::Standard->import({ into => $for_class });
    Types::Path::Tiny->import({ into => $for_class });
    Types::DateTime->import({ into => $for_class });
}

1;
