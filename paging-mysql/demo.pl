#! /usr/local/bin/perl
use strict;
use warnings;
use lib qw(./lib);
use Demo::DBPager;
use Data::Dumper;

my $db = Demo::DB->new;
$db->connect({dsn => 'dbi:mysql:skinny_demo', username => 'root', });

$db->do(q{
    CREATE TABLE user (
        id         INTEGER PRIMARY KEY AUTO_INCREMENT,
        name       VARCHAR(255) NOT NULL,
        UNIQUE(name)
    );
});

$db->bulk_insert('user',
    [
        { name => 'nekokak'  },
        { name => 'kazuho'   },
        { name => 'yappo'    },
        { name => 'nekoya'   },
        { name => 'oinume'   },
        { name => 'kan'      },
        { name => 'walf443'  },
        { name => 'yusukebe' },
        { name => 'hirose31' },
        { name => 'boofy'    },
    ]
);

my ($itr, $pager) = Demo::DBPager->users($db, 1);
warn Dumper $pager;
warn Dumper (map {$_->get_columns} $itr->all);

($itr, $pager) = Demo::DBPager->users($db, 2);
warn Dumper $pager;
warn Dumper (map {$_->get_columns} $itr->all);

$db->do(q{DROP TABLE user});


