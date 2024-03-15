package lib.cloudformation.CB_CFT_076

test_verify_load_balancer_tls_pass {
    result := passed with input as {
        "Resources": {
            "MyListener": {
                "Type": "AWS::ElasticLoadBalancingV2::Listener",
                "Properties": {
                    "Protocol": "TLS",
                    "SslPolicy": "ELBSecurityPolicy-TLS13-1-2"
                }
            }
        }
    }
    count(result) == 1
}

test_verify_load_balancer_tls_fail {
    result := failed with input as {
        "Resources": {
            "MyListener": {
                "Type": "AWS::ElasticLoadBalancingV2::Listener",
                "Properties": {
                    "Protocol": "HTTPS",
                    "SslPolicy": "ELBSecurityPolicy-TLS13-1-1"
                }
            }
        }
    }
    count(result) == 1
}
