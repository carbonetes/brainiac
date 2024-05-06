package lib.terraform.CB_TFAWS_125
import rego.v1

test_elb_uses_ssl_certificate if{
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_elb",
			"test",
		],
		"Attributes": {},
		"Blocks": [{
			"Type": "listener",
			"Labels": [],
			"Attributes": {
				"instance_port": "8000",
				"instance_protocol": "http",
				"lb_port": "443",
				"lb_protocol": "https",
				"ssl_certificate_id": "arn:aws:iam::123456789012:server-certificate/certName",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 9,
				"startLine": 3,
			},
		}],
		"line_range": {
			"endLine": 10,
			"startLine": 1,
		},
	}]

	count(result) == 1
}

test_elb_not_using_ssl_certificate if{
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_elb",
			"test",
		],
		"Attributes": {},
		"Blocks": [{
			"Type": "listener",
			"Labels": [],
			"Attributes": {
				"instance_port": "8000",
				"instance_protocol": "http",
				"lb_port": "443",
				"lb_protocol": "https",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 9,
				"startLine": 3,
			},
		}],
		"line_range": {
			"endLine": 10,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
