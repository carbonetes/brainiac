package lib.terraform.CB_TFAWS_027
import rego.v1

test_aws_kinesis_stream_encrypted if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_kinesis_stream",
			"example",
		],
		"Attributes": {
			"encryption_type": "KMS",
			"name": "example-stream",
			"shard_count": "1",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 5,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_aws_kinesis_stream_not_encrypted if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_kinesis_stream",
			"example",
		],
		"Attributes": {
			"encryption_type": "invalid",
			"name": "example-stream",
			"shard_count": "1",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 5,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
