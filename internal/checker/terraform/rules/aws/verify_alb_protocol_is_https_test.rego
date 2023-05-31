package lib.terraform.CB_TFAWS_002

test_with_secured_protocol{
    result := passed with input as [
        {
            "Type": "resource",
            "Labels": [
                "aws_alb_listener",
                "example"
            ],
            "Attributes": {
                "certificate_arn": "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4",
                "port": "443",
                "protocol": "TLS",
                "ssl_policy": "ELBSecurityPolicy-2016-08"
                },
            "Blocks": []
        }]
    count(result) == 1
}

test_with_unsecured_protocol {
    result := failed with input as [
        {
            "Type": "resource",
            "Labels": [
                "aws_alb_listener",
                "example"
            ],
            "Attributes": {
                "certificate_arn": "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4",
                "port": "443",
                "protocol": "HTTP",
                "ssl_policy": "ELBSecurityPolicy-2016-08"
                },
            "Blocks": []
        }]
    count(result) == 1
}