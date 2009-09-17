#! /usr/local/bin/perl
use strict;
use warnings;
use lib qw(./lib);
use Demo::DB;
use Demo::ShardManager;

my $sm = Demo::ShardManager->new;
my $db = Demo::DB->new;
$db->connect({dsn => 'dbi:SQLite:dbname=./db/demo_user.db', });

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

{
    my $user = $db->single('user', {name => 'nekokak'});

    my $shard_db = $sm->handler_for($user->id);
    my $status = $shard_db->insert('status',{ user_id => $user->id, body => 'hi!' });
    print $status->body, "\n";
}

{
    my $user = $db->single('user', {name => 'boofy'});

    my $shard_db = $sm->handler_for($user->id);
    my $status = $shard_db->insert('status',{ user_id => $user->id, body => 'booooooooofy' });
    print $status->body, "\n";
}

{

    my $user = $db->single('user', {name => 'nekokak'});
    my $shard_db = $sm->handler_for($user->id);
    $shard_db->delete('status');
    $user = $db->single('user', {name => 'boofy'});
    $shard_db = $sm->handler_for($user->id);
    $shard_db->delete('status');
    $db->delete('user');
}

