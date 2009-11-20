package b1::DM;
use strict;
use warnings;
use base 'Data::Model';
use Data::Model::Schema;
use Data::Model::Driver::DBI;

my $driver = Data::Model::Driver::DBI->new(
    dsn => 'dbi:SQLite:',
);
base_driver( $driver );
install_model mock => schema {
    key 'id';
    columns qw/id name/;
};
1;

