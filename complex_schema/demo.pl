#! /usr/local/bin/perl
use strict;
use warnings;
use lib qw(./lib);
use Demo::DB;
use Demo::DB2;
use Data::Dumper;

my $db = Demo::DB->new;
$db->connect({dsn => 'dbi:SQLite:./db/demo_user.db'});
$db->delete('user');
$db->bulk_insert('user',
    [
        { foo => 'nekokak', bar => 'aaa', },
    ]
);

$db->attribute->{profile} = 1;

$db->single('user', {foo => 'nekokak'});

warn Dumper $db->profiler->query_log;

my $db2 = Demo::DB2->new;
$db2->connect({dsn => 'dbi:SQLite:./db/demo_user2.db'});
$db2->delete('user');
$db2->bulk_insert('user',
    [
        { foo => 'kazuho' , baz => 'bbb', },
    ]
);

$db2->attribute->{profile} = 1;

$db2->single('user', {foo => 'nekokak'});

warn Dumper $db2->profiler->query_log;

