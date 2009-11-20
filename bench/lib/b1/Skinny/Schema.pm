package b1::Skinny::Schema;
use DBIx::Skinny::Schema;

install_table mock => schema {
    pk 'id';
    columns qw/id name/;
};

1;
