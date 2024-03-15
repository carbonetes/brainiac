package lib.cloudformation.CB_CFT_059

test_verify_elasticsearch_domain_enforces_https_enabled {
    result := passed with input as {"Resources": {
        "MyElasticsearchDomain": {
            "Type": "AWS::Elasticsearch::Domain",
            "Properties": {
                "DomainName": "<your-domain-name>",
                "DomainEndpointOptions": {
                    "EnforceHTTPS": true
                }
            }
        }
    }}
    count(result) == 1
}

test_verify_elasticsearch_domain_enforces_https_disabled {
    result := failed with input as {"Resources": {
        "MyElasticsearchDomain": {
            "Type": "AWS::Elasticsearch::Domain",
            "Properties": {
                "DomainName": "<your-domain-name>",
                "DomainEndpointOptions": {
                    "EnforceHTTPS": false
                }
            }
        }
    }}
    count(result) == 1
}