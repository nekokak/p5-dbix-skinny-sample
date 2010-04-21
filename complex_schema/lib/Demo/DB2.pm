package Demo::DB2;
use DBIx::Skinny;

package Demo::DB2::Schema;
use DBIx::Skinny::Schema;

install_table user => schema {
    pk 'id';
    columns qw/id foo baz/;
};

1;

