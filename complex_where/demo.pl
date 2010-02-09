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
        { foo => 'nekokak', bar => 'aaa', },
        { foo => 'kazuho' , bar => 'bbb', },
        { foo => 'yappo'  , bar => 'ccc', },
        { foo => 'nekoya' , bar => 'ddd', },
        { foo => 'oinume' , bar => 'eee', },
    ]
);

$db->attribute->{profile} = 1;

my $rs = $db->resultset(
    {
        select => '*',
        from   => 'user',
    }
);
$rs->add_complex_where([ 'or' => [ 'or' => {'foo' => 'nekokak'},{'bar' => 'bbb'}]]);
$rs->add_where(id => {'>' => 1});

$rs->retrieve;

warn Dumper $db->profiler->query_log;

