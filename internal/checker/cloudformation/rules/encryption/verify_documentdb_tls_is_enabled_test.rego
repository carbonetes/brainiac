package lib.cloudformation.CB_CFT_071

test_documentdb_tls_enabled {
	result := passed with input as {"Resources": {"DocDBParameterGroupEnabled": {
		"Type": "AWS::DocDB::DBClusterParameterGroup",
		"Properties": {"Parameters": {"tls": "enabled"}},
	}}}
	count(result) == 1
}

test_documentdb_tls_disabled  {
	result := passed with input as {"Resources": {"DocDBParameterGroupEnabled": {
		"Type": "AWS::DocDB::DBClusterParameterGroup",
		"Properties": {"Parameters": {"tls": "disabled"}},
	}}}
	count(result) == 0
}
