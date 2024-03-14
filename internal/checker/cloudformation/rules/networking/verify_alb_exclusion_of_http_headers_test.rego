package lib.cloudformation.CB_CFT_091

test_alb_drop_http_header {
	result := passed with input as {"Resources": {"MyLoadBalancer": {
		"Properties": {"LoadBalancerAttributes":[
            {
                "Key": "routing.http.drop_invalid_header_fields.enabled",
                "Value": "true",
            }
        ] },
		"Type": "AWS::ElasticLoadBalancingV2::LoadBalancer",
	}}}
	count(result) == 1
}

test_alb_not_drop_http_header {
	result := failed with input as {"Resources": {"MyLoadBalancer": {
		"Properties": {"LoadBalancerAttributes":[
            {
                "Key": "idle_timeout.timeout_seconds",
                "Value": "60",
            }
        ] },
		"Type": "AWS::ElasticLoadBalancingV2::LoadBalancer",
	}}}
	count(result) == 1
}
