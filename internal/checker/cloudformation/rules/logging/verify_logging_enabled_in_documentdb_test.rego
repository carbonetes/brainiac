package lib.cloudformation.CB_CFT_061

test_documentdb_logging_enabled {
	result := passed with input as {"Resources": {"MyDocDBCluster":{
        "Properties":{
            "EnableCloudwatchLogsExports": [
                "audit", "profiler"
            ]
        },
        "Type": "AWS::DocDB::DBCluster"
    }}}
	count(result) == 1
}

test_documentdb_logging_disabled {
	result := failed with input as {"Resources": {"MyDocDBCluster":{
        "Properties":{
            "EnableCloudwatchLogsExports": [
                "", ""
            ]
        },
        "Type": "AWS::DocDB::DBCluster"
    }}}
	count(result) == 1
}
