package lib.cloudformation.CB_CFT_068

test_elb_logging_access_enabled {
	result := passed with input as {"Resources": {"MyDocDBCluster": {
		"Type": "AWS::ElasticLoadBalancing::LoadBalancer",
		"Properties": {"AccessLoggingPolicy": {"Enabled": true}},
	}}}
	count(result) == 1
}

test_elb_logging_access_disabled {
	result := failed with input as {"Resources": {"MyDocDBCluster": {
		"Type": "AWS::ElasticLoadBalancing::LoadBalancer",
		"Properties": {"AccessLoggingPolicy": {"Enabled": false}},
	}}}
	count(result) == 1
}
