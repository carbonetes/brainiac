package lib.cloudformation.CB_CFT_024

test_viewer_protocol_is_https {
	result := passed with input as {
		"Resources": {
			"CloudFrontDistribution": {
				"Type": "AWS::CloudFront::Distribution",
				"Properties": {
					"DistributionConfig": {
						"DefaultCacheBehavior": {
							"ViewerProtocolPolicy": "HTTPS"
						},
						"CacheBehaviors": [
							{							
								"ViewerProtocolPolicy": "HTTPS"
							}
						]
					}
				}
			}
		}
	}
	count(result) == 1
}

test_viewer_protocol_is_not_https {
	result := failed with input as {
		"Resources": {
			"CloudFrontDistribution": {
				"Type": "AWS::CloudFront::Distribution",
				"Properties": {
					"DistributionConfig": {
						"DefaultCacheBehavior": {
							"ViewerProtocolPolicy": "HTTP"
						},
						"CacheBehaviors": [
							{		
								"ViewerProtocolPolicy": "HTTP"
							}
						]
					}
				}
			}
		}
	}
	count(result) == 1
}
