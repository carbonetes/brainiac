package lib.cloudformation.CB_CFT_094

test_redshift_not_outside_vpc {
	result := passed with input as {"Resources": {"RedshiftCluster": {
        "Type": "AWS::Redshift::Cluster",
        "Properties": {
              "ClusterSubnetGroupName": "RedshiftSubnetGroup"
        }
    }}}
	count(result) == 1
}

test_redshift_outside_vpc  {
	result := failed with input as {"Resources": {"RedshiftCluster": {
        "Type": "AWS::Redshift::Cluster",
        "Properties": {
              "ClusterSubnetGroupName": ""
        }
    }}}
	count(result) == 1
}
