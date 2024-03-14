package lib.cloudformation.CB_CFT_090

test_vpc_endpoint_service_manual_acceptance {
	result := passed with input as {"Resources": {"MyVPCEndpointService": {
		"Properties": {"AcceptanceRequired": true},
		"Type": "AWS::EC2::VPCEndpointService",
	}}}
	count(result) == 1
}

test_vpc_endpoint_service_not_manual_acceptance {
	result := failed with input as {"Resources": {"MyVPCEndpointService": {
		"Properties": {"AcceptanceRequired": false},
		"Type": "AWS::EC2::VPCEndpointService",
	}}}
	count(result) == 1
}
