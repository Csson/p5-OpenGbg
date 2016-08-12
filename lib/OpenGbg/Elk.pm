use 5.10.0;
use strict;
use warnings;

package OpenGbg::Elk;

# AUTHORITY
our $VERSION = '0.1403';

use Moose();
use MooseX::AttributeShortcuts();
use Moose::Exporter;

Moose::Exporter->setup_import_methods(also => ['Moose']);

sub init_meta {
    my $class = shift;

    my %params = @_;
    my $for_class = $params{'for_class'};
    Moose->init_meta(@_);
    MooseX::AttributeShortcuts->init_meta(for_class => $for_class);
}

1;
