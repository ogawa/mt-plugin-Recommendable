# $Id$

package MT::Plugin::Recommendable;
use strict;
use base qw( MT::Plugin );

our $VERSION        = '0.01';
our $SCHEMA_VERSION = '0.01';

my $plugin = __PACKAGE__->new(
    {
        id             => 'recommendable',
        name           => 'Recommendable',
        description    => 'Framework for recommendation engines',
        author_name    => 'Hirotaka Ogawa',
        author_link    => 'http://as-is.net/blog/',
        version        => $VERSION,
        schema_version => $SCHEMA_VERSION,
    }
);
MT->add_plugin($plugin);

sub instance { $plugin }

sub init_registry {
    my $plugin = shift;
    $plugin->registry(
        {
            object_types => {
                entry           => 'MT::Recommendable',
                objectrecommend => 'MT::ObjectRecommend',
            }
        }
    );
}

1;
