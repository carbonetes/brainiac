package lib.cloudformation.CB_CFT_117

test_verify_elasticsearch_domain_audit_logs_enabled {
    result := passed with input as {"Resources": {
    "MyElasticsearchDomain": {
      "Type": "AWS::Elasticsearch::Domain",
      "Properties": {
        "LogPublishingOptions": {
          "AUDIT_LOGS": {
            "Enabled": true
          }
        }
      }
    }
  }
}
        count(result) == 1
}

test_verify_elasticsearch_domain_audit_logs_disabled {
    result := failed with input as {"Resources": {
    "MyElasticsearchDomain": {
      "Type": "AWS::Elasticsearch::Domain",
      "Properties": {
        "LogPublishingOptions": {
          "AUDIT_LOGS": {
            "Enabled": false
          }
        }
      }
    }
  }
}
        count(result) == 1
}