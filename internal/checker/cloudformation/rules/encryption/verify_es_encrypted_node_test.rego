package lib.cloudformation.CB_CFT_004

test_es_node_is_encrypted {
	result := passed with input as {
    "Resources": {
        "ElasticsearchDomain": {
            "Type": "AWS::Elasticsearch::Domain",
            "Properties": {
                "NodeToNodeEncryptionOptions": {
                    "Enabled": true
                }
            }
        }
    }
}
	count(result) == 1
}

test_es_node_is_not_encrypted {
	result := failed with input as {
    "Resources": {
        "ElasticsearchDomain": {
            "Type": "AWS::Elasticsearch::Domain",
             "Properties": {
                "NodeToNodeEncryptionOptions": {
                    "Enabled": false
                }
            }
        }
    }
}
	count(result) == 1
}
