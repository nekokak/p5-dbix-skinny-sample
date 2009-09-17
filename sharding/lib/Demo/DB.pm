package Demo::DB;
use DBIx::Skinny;

package Demo::DB::Schema;
use DBIx::Skinny::Schema;

install_table user => schema {
    pk 'id';
    columns qw/id name/;
};

1;

