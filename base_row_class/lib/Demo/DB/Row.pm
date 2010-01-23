package Demo::DB::Row;
use strict;
use warnings;
use base 'DBIx::Skinny::Row';
use JSON::XS qw/encode_json/;

sub to_json {
    my $self = shift;
    encode_json($self->get_columns);
}

1;

