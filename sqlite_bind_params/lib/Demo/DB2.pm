package Demo::DB2;
use DBIx::Skinny;

package Demo::DB2::Schema;
use DBIx::Skinny::Schema;

install_table user => schema {
    pk 'id';
    my @columns = (
        'id',
        {
            name => 'foo',
            type => 'blob',
        },
    );
    columns @columns;
};

1;

