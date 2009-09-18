package Demo::Name;
use strict;
use warnings;
use utf8;

sub new {
    my ($class, $name) = @_;
    bless {name => $name}, $class;
}

sub get_name { $_[0]->{name} }

1;

