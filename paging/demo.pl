#! /usr/local/bin/perl
use strict;
use warnings;
use lib qw(./lib);
use Demo::DB;
use Demo::DBPager;
use Data::Dumper;

my $db = Demo::DB->new;
$db->connect({dsn => 'dbi:SQLite:./db/demo_user.db'});

$db->delete('user');

$db->bulk_insert('user',
    [
        { name => 'nekokak'  },
        { name => 'kazuho'   },
        { name => 'yappo'    },
        { name => 'nekoya'   },
        { name => 'oinume'   },
    ]
);

my ($rows, $pager) = Demo::DBPager->users($db, 1);
warn Dumper $pager;
warn Dumper $rows;

($rows, $pager) = Demo::DBPager->users($db, 2);
warn Dumper $pager;
warn Dumper $rows;

($rows, $pager) = Demo::DBPager->users($db, 3);
warn Dumper $pager;
warn Dumper $rows;

