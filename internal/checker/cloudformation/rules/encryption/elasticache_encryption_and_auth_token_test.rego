package lib.cloudformation.CB_CFT_021

test_elasticache_encryption_and_auth_token_passed {
    result := passed with input as {
        "Resources": [
            {
                "Type": "AWS::ElastiCache::ReplicationGroup",
                "Properties": {
                    "TransitEncryptionEnabled": true,
                    "AuthToken": "my-auth-token"
                }
            }
        ]
    }
    count(result) == 1
}

test_elasticache_encryption_and_auth_token_failed {
    result := failed with input as {
        "Resources": [
            {
                "Type": "AWS::ElastiCache::ReplicationGroup",
                "Properties": {
                    "TransitEncryptionEnabled": false,
                    "AuthToken": ""
                }
            }
        ]
    }
    count(result) == 1
}