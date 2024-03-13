package lib.cloudformation.CB_CFT_062

test_cloudfront_distribution_access_enabled {
	result := passed with input as {"Resources": {"MyCloudFrontDistribution": {
        "Properties": {
            "DistributionConfig": {
                "Logging": {
                    "Bucket": "myawslogbucket.s3.amazonaws.com",
                }
            }
        },
        "Type": "AWS::CloudFront::Distribution",
    }}}
	count(result) == 1
}

test_cloudfront_distribution_access_not_enabled {
	result := failed with input as {"Resources": {"MyCloudFrontDistribution": {
        "Properties": {
            "DistributionConfig": {
                "Logging": {
                    "Bucket": "",
                }
            }
        },
        "Type": "AWS::CloudFront::Distribution",
    }}}
	count(result) == 1
}
