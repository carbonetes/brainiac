package lib.cloudformation.CB_CFT_020

test_verify_elasticache_encryption_at_transit_enabled {
    result := passed with input as {"Resources": {
    "MyElastiCacheReplicationGroup": {
      "Type": "AWS::ElastiCache::ReplicationGroup",
      "Properties": {
        "ReplicationGroupId": "MyReplicationGroup",
        "Engine": "redis",
        "CacheNodeType": "cache.t2.small",
        "NumCacheClusters": 2,
        "TransitEncryptionEnabled": true
      }
    }
  }
}
        count(result) == 1
}

test_verify_elasticache_encryption_at_transit_disabled  {
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