package lib.cloudformation.CB_CFT_003

test_es_is_encrypted_rest {
	result := passed with input as {
    "Resources": {
        "ElasticsearchDomain": {
            "Type": "AWS::Elasticsearch::Domain",
            "Properties": {
                "EncryptionAtRestOptions": {
                    "Enabled": true
                }
            }
        }
    }
}
	count(result) == 1
}

test_es_is_not_encrypted_rest {
	result := failed with input as {
    "Resources": {
        "ElasticsearchDomain": {
            "Type": "AWS::Elasticsearch::Domain",
             "Properties": {
                "EncryptionAtRestOptions": {
                    "Enabled": false
                }
            }
        }
    }
}
	count(result) == 1
}
