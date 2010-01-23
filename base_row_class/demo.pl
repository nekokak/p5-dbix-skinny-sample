#! /usr/local/bin/perl
use strict;
use warnings;
use lib qw(./lib);
use Demo::DB;
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

my $itr = $db->search('user');

my @json = map { $_->to_json } $itr->all;
warn Dumper \@json;
