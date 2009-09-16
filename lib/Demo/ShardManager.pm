package Demo::ShardManager;
use strict;
use warnings;
use DBIx::ShardManager::Definition::JSON;
use Demo::ShardDB;

sub new {
    my $class = shift;
    bless {}, $class;
}

sub handler_for {
    my ($self, $shard_key) = @_;

    $self->{_sm} ||= DBIx::ShardManager::Definition::JSON->new(
        file => './assets/shard_def.json',
    );

    my $info = $self->{_sm}->get_conn_info($shard_key);

    $self->{'_cache'.$info->{dbname}} or do {
        my $db = Demo::ShardDB->new;
        $db->connect({dsn => 'dbi:'.$info->{driver}.':dbname='.$info->{dbname}});
        $self->{'_cache'.$info->{dbname}} = $db;
    };
}

1;

