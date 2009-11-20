#! /usr/local/bin/perl
use strict;
use warnings;
use lib qw(./lib);
use Benchmark qw/cmpthese/;
use b1::Skinny;
use b1::DBIC;
use b1::DM;

my $dbic = b1::DBIC->connect('dbi:SQLite:');
my $dm = b1::DM->new;
my $skinny = b1::Skinny->new;
my $sql = q{
    CREATE TABLE mock (
        id   INT,
        name TEXT
    );
};

$skinny->do($sql);
$dbic->storage->dbh->do($sql);
my $rs = $dbic->resultset('Mock');
$dm->get_driver('mock')->rw_handle->do($sql);

print "insert: \n";
my $skinny_id=0;
my $dm_id=0;
my $dbic_id=0;
cmpthese(100, {
    datamodel => sub { 
        for my $id (1..200) {
            $dm_id++;
            $dm->set('mock', {id => $dm_id, name => 'name'.$dm_id});
        }
    },
    dbic      => sub {
        for my $id (1..200) {
            $dbic_id++;
            $rs->create({id => $dbic_id, name => 'name'.$dbic_id});
        }
    },
    skinny    => sub {
        for my $id (1..200) {
            $skinny_id++;
            $skinny->insert('mock',{id => $skinny_id, name => 'name'.$skinny_id});
        }
    },
});

$skinny_id=0;
$dm_id=0;
$dbic_id=0;
cmpthese(100, {
    datamodel => sub { 
        for (1..200) {
            $dm_id++;
            $dm->update_direct('mock' => $dm_id, undef => {name => 'update_name'.$dm_id});
        }
    },
    dbic      => sub {
        for (1..200) {
            $dbic_id++;
            $rs->search({id => $dbic_id})->update({name => 'update_name'.$dbic_id});
        }
    },
    skinny    => sub {
        for (1..200) {
            $skinny_id++;
            $skinny->update('mock',{name => 'update_name'.$skinny_id},{id => $skinny_id});
        }
    },
});

print "select: \n";
cmpthese(100, {
    skinny    => sub { my @rows = $skinny->search('mock',{}) },
    dbic      => sub { my @rows = $rs->search },
    datamodel => sub { my @rows = $dm->get('mock') },
});

$skinny_id=0;
$dm_id=0;
$dbic_id=0;
cmpthese(100, {
    datamodel => sub {
        for (1..200) {
            $dm_id++;
            $dm->delete('mock' => $dm_id);
        }
    },
    dbic      => sub {
        for (1..200) {
            $dbic_id++;
            $rs->search({id => $dbic_id})->delete;
        }
    },
    skinny    => sub {
        for (1..200) {
            $skinny_id++;
            $skinny->delete('mock',{id => $skinny_id});
        }
    },
});

