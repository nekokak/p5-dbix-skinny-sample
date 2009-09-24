package Demo::DBPager;
use strict;
use warnings;
use Data::Page;

sub users {
    my ($self, $db, $page) = @_;

    my $limit  = 2;
    my $offset = $limit*($page-1);

    my $itr = $db->search_by_sql(q{SELECT SQL_CALC_FOUND_ROWS * FROM user LIMIT ? OFFSET ?},[$limit, $offset]);
    my $rows = $db->search_by_sql('SELECT FOUND_ROWS() AS row')->first;

    my $pager = Data::Page->new(
        $rows->row, $limit, $page
    );
    return ($itr, $pager);
}

1;

