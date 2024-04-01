package lib.terraform.CB_TFAWS_048
import rego.v1

test_aws_instance_secrets_passed if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_instance",
			"example",
		],
		"Attributes": {
			"ami": "ami-0c55b159cbfafe1f0",
			"instance_type": "t2.micro",
			"user_data": "#!/bin/bash\necho \"This is my user data script\"\n",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 10,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_aws_instance_secrets_failed if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_instance",
			"example",
		],
		"Attributes": {
			"ami": "ami-0c55b159cbfafe1f0",
			"instance_type": "t3.micro",
			"key_name": "example-key",
			"user_data": "access_key=123456ABCDEFGHIJZTLA and secret_key=AAAaa+Aa4AAaAA6aAkA0Ad+Aa8aA1aaaAAAaAaA",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 11,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
