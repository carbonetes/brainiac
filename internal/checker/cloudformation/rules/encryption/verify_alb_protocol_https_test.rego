package lib.cloudformation.CB_CFT_001

test_alb_protocol_is_https {
	result := passed with input as {"Resources": {"ListenerHTTPS": {
		"Type": "AWS::ElasticLoadBalancingV2::Listener",
		"Properties": {
			"Protocol": "HTTPS",
		},
	}}}
	count(result) == 1
}

test_alb_protocol_is_not_https {
	result := failed with input as {"Resources": {"ListenerHTTPS": {
		"Type": "AWS::ElasticLoadBalancingV2::Listener",
		"Properties": {
			"Protocol": "HTTP"
		},
	}}}
	count(result) == 1
}
