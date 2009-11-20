package b1::DBIC::Result::Mock;
use base qw/DBIx::Class/;
__PACKAGE__->load_components(qw/Core/);
__PACKAGE__->table('mock');
__PACKAGE__->add_columns(qw/id name/);
__PACKAGE__->set_primary_key('id');
1;
