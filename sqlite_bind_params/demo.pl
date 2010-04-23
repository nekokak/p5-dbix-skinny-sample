#! /usr/local/bin/perl
use strict;
use warnings;
use lib qw(./lib);
use Demo::DB;
use Demo::DB2;
use Data::Dumper;
use File::Slurp;

my $bin = read_file('./neko.jpg');

my $db = Demo::DB->new;
$db->connect({dsn => 'dbi:SQLite:./db/demo_user.db'});
$db->delete('user');
$db->bulk_insert('user',
    [
        { hoge => $bin },
    ]
);

$db->attribute->{profile} = 1;

my $tmp = $db->single('user', );
warn $tmp->hoge eq $bin ? 'ok' : 'ng';

warn Dumper $db->profiler->query_log;

my $db2 = Demo::DB2->new;
$db2->connect({dsn => 'dbi:SQLite:./db/demo_user2.db'});
$db2->delete('user');

$db2->bulk_insert('user',
    [
        { foo => $bin },
    ]
);

$db2->attribute->{profile} = 1;

my $row = $db2->single('user',);

warn $row->foo eq $bin ? 'ok' : 'ng';

$row = $db2->single('user', {foo => $bin});
warn Dumper $row;

