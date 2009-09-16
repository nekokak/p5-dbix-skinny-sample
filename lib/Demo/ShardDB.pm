package Demo::ShardDB;
use DBIx::Skinny;

package Demo::ShardDB::Schema;
use DBIx::Skinny::Schema;

install_table status => schema {
    pk 'id';
    columns qw/id user_id body/;
};

1;

