package lib.cloudformation.CB_CFT_019

test_verify_elasticache_encryption_at_rest_enabled {
    result := passed with input as {"Resources": {
    "MyElastiCacheReplicationGroup": {
      "Type": "AWS::ElastiCache::ReplicationGroup",
      "Properties": {
        "ReplicationGroupId": "MyReplicationGroup",
        "Engine": "redis",
        "CacheNodeType": "cache.t2.small",
        "NumCacheClusters": 2,
        "AtRestEncryptionEnabled": true
      }
    }
  }
}
        count(result) == 1
}

test_verify_elasticache_encryption_at_rest_disabled  {
    result := failed with input as {"Resources": {
    "MyElastiCacheReplicationGroup": {
      "Type": "AWS::ElastiCache::ReplicationGroup",
      "Properties": {
        "ReplicationGroupId": "MyReplicationGroup",
        "Engine": "redis",
        "CacheNodeType": "cache.t2.small",
        "NumCacheClusters": 2,
      }
    }
  }
}
        count(result) == 1
}