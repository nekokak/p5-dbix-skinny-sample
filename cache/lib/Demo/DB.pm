package Demo::DB;
use DBIx::Skinny;

package Demo::DB::Schema;
use DBIx::Skinny::Schema;

install_table user => schema {
    pk 'id';
    columns qw/id name/;
};

install_inflate_rule '^name$' => callback {
    inflate {
        my $value = shift;
        Demo::Name->new($value);
    };
    deflate {
        my $obj = shift;
        $obj->get_name;
    };
};

1;

