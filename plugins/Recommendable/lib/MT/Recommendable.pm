# $Id$

# An interface for any MT::Object that wishes to utilize recommendation engines

package MT::Recommendable;

use strict;
use MT::ObjectRecommend;
use MT::Memcached;

use constant RECOMMEND_CACHE_TIME => 7 * 24 * 60 * 60;    ## 1 week

sub install_properties {
    my $pkg = shift;
    my ($class) = @_;
    $class->add_trigger( post_remove => \&post_remove_recommend );
}

sub post_remove_recommend {
    my $class = shift;
    my ($obj) = @_;
    MT::ObjectRecommend->remove(
        {
            object_ds => $obj->datasource,
            object_id => $obj->id,
        }
    );
}

sub get_recommends {
    my $obj = shift;
    my ($namespace) = @_;

    my $term = {
        namespace => $namespace,
        object_id => $obj->id,
        object_ds => $obj->datasource,
    };
    MT::ObjectRecommend->load($term) or return undef;
}

sub set_recommend {
    my $obj = shift;
    my ( $namespace, $target_id, $rank ) = @_;

    my $term = {
        namespace => $namespace,
        object_id => $obj->id,
        object_ds => $obj->datasource,
        target_id => $target_id,
    };
    my ($rec) = MT::ObjectRecommend->load($term);
    unless ($rec) {
        $rec = MT::ObjectRecommend->new;
        $rec->set_values($term);
    }
    $rec->rank($rank);
    $rec->save
      or return $obj->error(
        MT->translate(
            "Could not set recommend to the object '[_1]'(ID: [_2])",
            $obj->datasource, $obj->id
        )
      );
    $rec;
}

# TODO: caching
sub __load_recommends {
    my $obj = shift;
    my ($term) = @_;
    MT::ObjectRecommend->load($term);
}

# TODO: caching
sub __load_recommend {
    my $obj = shift;
    my ($term) = @_;
    MT::ObjectRecommend->load($term);
}

1;
