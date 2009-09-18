package Demo::Cache;
use strict;
use warnings;
use utf8;
use Cache::Memcached::Fast;

sub new {
    bless {
        memd => Cache::Memcached::Fast->new(
            {
                namespace => __PACKAGE__,
                servers   => ['127.0.0.1:11211'],
            }
        ),
    }, __PACKAGE__; 
}

sub get_callback {
    my ($self, $opt) = @_;

    my $data = $self->{memd}->get($opt->{cache_key});
    if (defined $data) {
        return $opt->{on_complete} ? $opt->{on_complete}->($data) : $data;
    }

    $data = $opt->{callback}->();
    if (defined $data) {
        $self->{memd}->set($opt->{cache_key} => $data, $opt->{exptime});
        return $opt->{on_complete} ? $opt->{on_complete}->($data) : $data;
    }

    return;
}

1;

