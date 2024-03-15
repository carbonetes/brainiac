package lib.cloudformation.CB_CFT_066

test_documentdb_tls_enabled {
	result := passed with input as {"Resources": {"DocDBParameterGroupEnabled": {
		"Type": "AWS::DocDB::DBClusterParameterGroup",
		"Properties": {"Parameters": {"tls": "enabled"}},
	}}}
	count(result) == 1
}

test_documentdb_tls_disabled  {
	result := failed with input as {"Resources": {"DocDBParameterGroupEnabled": {
		"Type": "AWS::DocDB::DBClusterParameterGroup",
		"Properties": {"Parameters": {"tls": "disabled"}},
	}}}
	count(result) == 1
}
