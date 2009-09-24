package Demo::DBPager;
use strict;
use warnings;
use Data::Page;

sub users {
    my ($self, $db, $page) = @_;

    my $limit  = 2;
    my $offset = $limit*($page-1);

    my @rows = map { $_->get_columns } $db->search_by_sql(q{SELECT * FROM user LIMIT ? OFFSET ?},[($limit+1), $offset]);

    my $has_next = scalar(@rows) > $limit ? 1 : 0;
    if ($has_next) {
        pop @rows;
    }

    my $total_rows = ($limit * $page) + $has_next - (scalar(@rows) < $limit ? 1 : 0);

    my $pager = Data::Page->new(
        $total_rows,
        $limit,
        $page,
    );

    return (\@rows, $pager);
}

1;

