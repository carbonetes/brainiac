package lib.cloudformation.CB_CFT_060

test_verify_elasticsearch_domain_logging_enabled {
    result := passed with input as {"Resources": {
        "MyElasticsearchDomain": {
            "Type": "AWS::Elasticsearch::Domain",
            "Properties": {
                "DomainName": "<your-domain-name>",
                "LogPublishingOptions": {
                    "INDEX_SLOW_LOGS": {
                        "CloudWatchLogsLogGroupArn": "<your-log-group-arn>",
                        "Enabled": true
                    }
                }
            }
        }
    }}
    count(result) == 1
}

test_verify_elasticsearch_domain_logging_disabled {
    result := failed with input as {"Resources": {
        "MyElasticsearchDomain": {
            "Type": "AWS::Elasticsearch::Domain",
            "Properties": {
                "DomainName": "<your-domain-name>",
                "LogPublishingOptions": {
                    "INDEX_SLOW_LOGS": {
                        "CloudWatchLogsLogGroupArn": "<your-log-group-arn>",
                        "Enabled": false
                    }
                }
            }
        }
    }}
    count(result) == 1
}