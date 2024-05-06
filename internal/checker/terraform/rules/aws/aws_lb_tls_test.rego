package lib.terraform.CB_TFAWS_065
import rego.v1

test_aws_lb_tls_passed if {
    result := passed with input as [
                            {
                            "Type": "resource",
                            "Labels": [
                            "aws_lb_listener",
                            "front_end"
                            ],
                            "Attributes": {
                            "certificate_arn": "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4",
                            "load_balancer_arn": "aws_lb.front_end.arn",
                            "port": "443",
                            "protocol": "HTTPS",
                            "ssl_policy": "ELBSecurityPolicy-TLS13-1-2-2021-06"
                            },
                            "Blocks": [
                            {
                                "Type": "default_action",
                                "Labels": [],
                                "Attributes": {
                                "target_group_arn": "aws_lb_target_group.front_end.arn",
                                "type": "forward"
                                },
                                "Blocks": [],
                                "line_range": {
                                "endLine": 11,
                                "startLine": 8
                                }
                            }
                            ],
                            "line_range": {
                            "endLine": 12,
                            "startLine": 1
                            }
                            }
                            ]
    count(result) == 1
}

test_aws_lb_tls_failed if {
    result := failed with input as[
                             {
                            "Type": "resource",
                            "Labels": [
                            "aws_lb_listener",
                            "front_end"
                            ],
                            "Attributes": {
                            "certificate_arn": "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4",
                            "load_balancer_arn": "aws_lb.front_end.arn",
                            "port": "443",
                            "protocol": "HTTPS",
                            "ssl_policy": "ELBSecurityPolicy-2016-08"
                            },
                            "Blocks": [
                            {
                                "Type": "default_action",
                                "Labels": [],
                                "Attributes": {
                                "target_group_arn": "aws_lb_target_group.front_end.arn",
                                "type": "forward"
                                },
                                "Blocks": [],
                                "line_range": {
                                "endLine": 11,
                                "startLine": 8
                                }
                            }
                            ],
                            "line_range": {
                            "endLine": 12,
                            "startLine": 1
                            }
                            }
                            ]
    count(result) == 1
}