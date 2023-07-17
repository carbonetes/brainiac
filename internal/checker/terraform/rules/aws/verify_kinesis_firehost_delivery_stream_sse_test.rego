package lib.terraform.CB_TFAWS_229

test_verify_kinesis_firehost_delivery_stream_sse_passed {
	result := passed with input as [
									{
									"Type": "resource",
									"Labels": [
									"aws_kinesis_firehose_delivery_stream",
									"pass"
									],
									"Attributes": {},
									"Blocks": [
									{
										"Type": "server_side_encryption",
										"Labels": [],
										"Attributes": {
										"enabled": true
										},
										"Blocks": [],
										"line_range": {
										"endLine": 4,
										"startLine": 2
										}
									}
									],
									"line_range": {
									"endLine": 5,
									"startLine": 1
									}
									}
									]
	count(result) == 1
}

test_verify_kinesis_firehost_delivery_stream_sse_failed {
	result := failed with input as [
									{
									"Type": "resource",
									"Labels": [
									"aws_kinesis_firehose_delivery_stream",
									"pass"
									],
									"Attributes": {},
									"Blocks": [
									{
										"Type": "server_side_encryption",
										"Labels": [],
										"Attributes": {
										"enabled": false
										},
										"Blocks": [],
										"line_range": {
										"endLine": 4,
										"startLine": 2
										}
									}
									],
									"line_range": {
									"endLine": 5,
									"startLine": 1
									}
									}
									]
	count(result) == 1
}
