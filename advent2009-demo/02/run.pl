use strict;
use warnings;
use lib './lib';
use Proj::DB;

# 実験なので実際にファイルをつくらずメモリ上で試す
# DBコネクションの作成
my $db = Proj::DB->new({dsn => 'dbi:SQLite:'});
# 実験用テーブルを作成
$db->do(q{
    create table user (
        id       INTEGER PRIMARY KEY AUTOINCREMENT,
        name     TEXT    NOT NULL,
        birth_on DATE
    )
});

# INSERT INTO user (name), VALUES ('nekokak');
# を実行
my $row = $db->create('user',{name => 'nekokak'});
print $row->id, "\n";   # print 1
print $row->name, "\n"; # print 'nekokak'

# UPDATE user set name = 'yappo' WHERE id = 1;
# を実行
# $row->update({name => 'yappo'});でも同じ
$db->update('user',{name => 'yappo'}, {id => $row->id});

# SELECT * FROM user WHERE name = 'nekokak'
# を実行
$row = $db->search('user', {name => 'yappo'})->first;
print $row->id, "\n";   # print 1
print $row->name, "\n"; # print 'yappo'

# SELECT * FROM user WHERE id = 1 limit 1;
# を実行
$row = $db->single('user', {id => 1});
print $row->id, "\n";   # print 1
print $row->name, "\n"; # print 'yappo'

# DELETE FROM user WHERE id = 1;
# を実行
$db->delete('user',{id =>1});


