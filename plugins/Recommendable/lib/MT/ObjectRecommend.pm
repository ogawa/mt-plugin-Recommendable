# $Id$

package MT::ObjectRecommend;

use strict;
use base qw( MT::Object );

__PACKAGE__->install_properties(
    {
        column_defs => {
            'id'        => 'integer not null auto_increment',
            'namespace' => 'string(255) not null',
            'object_ds' => 'string(50) not null',
            'object_id' => 'integer',
            'target_id' => 'integer',
            'rank'      => 'float',
        },
        indexes => {
            object_ds => 1,
            object_id => 1,
            target_id => 1,
            ds_obj    => { columns => [ 'object_ds', 'object_id' ], },
            ns_ds_obj =>
              { columns => [ 'namespace', 'object_ds', 'object_id' ], },
        },
        datasource  => 'objectrecommend',
        primary_key => 'id',
    }
);

sub class_label {
    MT->translate("Recommend Placement");
}

sub class_label_plural {
    MT->translate("Recommend Placements");
}

1;
