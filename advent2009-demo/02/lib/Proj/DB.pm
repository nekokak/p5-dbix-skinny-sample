package Proj::DB;
use DBIx::Skinny;
1;

package Proj::DB::Schema;
use DBIx::Skinny::Schema;

install_table user => schema {
    pk 'id';
    columns qw/id name birth_on/;
};
1;

