requires 'perl', '5.014000';

requires 'XML::LibXML';
requires 'XML::Rabbit';
requires 'Config::Any';
requires 'DateTime';
requires 'DateTime::Format::HTTP';
requires 'File::HomeDir';
requires 'HTTP::Tiny';
requires 'Kavorka';
requires 'Moops';
requires 'Moose';
requires 'MooseX::AttributeShortcuts';
requires 'Path::Tiny';
requires 'Sub::Exporter';
requires 'Syntax::Feature::Qs';
requires 'Type::Tiny';
requires 'Types::DateTime';
requires 'Types::Path::Tiny';
requires 'Throwable::X';

on 'build' => sub {
    requires 'XML::LibXML';
}
