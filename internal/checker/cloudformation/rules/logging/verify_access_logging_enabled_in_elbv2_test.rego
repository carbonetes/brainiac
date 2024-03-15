package lib.cloudformation.CB_CFT_067

test_access_logging_enabled_elbv2 {
	result := passed with input as {"Resources": {"MyLoadBalancer": {
		"Type": "AWS::ElasticLoadBalancingV2::LoadBalancer",
		"Properties": {"LoadBalancerAttributes": [{"Value": true}]},
	}}}
	count(result) == 1
}

test_access_logging_disabled_elbv2 {
	result := failed with input as {"Resources": {"MyLoadBalancer": {
		"Type": "AWS::ElasticLoadBalancingV2::LoadBalancer",
		"Properties": {"LoadBalancerAttributes": [{"Value": false}]},
	}}}
	count(result) == 1
}
