package lib.cloudformation.CB_CFT_050

test_cloudfront_has_waf_enabled {
    result := passed with input as {
        "Resources": {
            "CloudFrontDistribution": {
                "Type": "AWS::CloudFront::Distribution",
                "Properties": {
                    "DistributionConfig": {
                        "Aliases": ["example.com"],
                        "DefaultRootObject": "index.html",
                        "Enabled": true,
                        "WebACLId": "arn:aws:wafv2:us-east-1:123456789012:global/webacl/ExampleWebACL/12345"
                    }
                }
            }
        }
    }
    count(result) == 1
}

test_cloudfront_does_not_have_waf_enabled {
    result := failed with input as {
        "Resources": {
            "CloudFrontDistribution": {
                "Type": "AWS::CloudFront::Distribution",
                "Properties": {
                    "DistributionConfig": {
                        "Aliases": ["example.com"],
                        "DefaultRootObject": "index.html",
                        "Enabled": true,
                        "WebACLId": ""
                    }
                }
            }
        }
    }
    count(result) == 1
}
