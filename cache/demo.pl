#! /usr/local/bin/perl
use strict;
use warnings;
use lib qw(./lib);
use Demo::DB;
use Demo::Cache;
use Demo::Name;
use Data::Dumper;

my $db = Demo::DB->new;
$db->connect({dsn => 'dbi:SQLite:dbname=./db/demo_user.db', });

my $name = Demo::Name->new('nekokak');
$db->insert('user', { name => $name });

my $cache = Demo::Cache->new;
my $row = $cache->get_callback(
    {
        cache_key => 'user',
        exptime   => 30,
        callback  => sub {
            my $user = $db->single('user', { name => 'nekokak' });
            $user ? $user->get_columns : undef;
        },
        on_complete => sub {
            my $user = shift;
            $db->data2itr('user', [$user])->first;
        },
    }
);

warn Dumper $row;
warn Dumper $row->name;

$db->delete('user');

