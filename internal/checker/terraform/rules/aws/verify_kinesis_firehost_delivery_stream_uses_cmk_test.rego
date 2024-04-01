package lib.terraform.CB_TFAWS_232
import rego.v1

test_verify_kinesis_firehost_delivery_stream_uses_cmk_passed if {
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
										"enabled": true,
										"key_arn": "aws_kms_key.example.arn",
										"key_type": "CUSTOMER_MANAGED_CMK"
										},
										"Blocks": [],
										"line_range": {
										"endLine": 6,
										"startLine": 2
										}
									}
									],
									"line_range": {
									"endLine": 7,
									"startLine": 1
									}
									}
									]
	count(result) == 1
}

test_verify_kinesis_firehost_delivery_stream_uses_cmk_failed if {
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
										"enabled": false,
										"key_arn": "aws_kms_key.example.arn",
										"key_type": "CUSTOMER_MANAGED_CMK"
										},
										"Blocks": [],
										"line_range": {
										"endLine": 6,
										"startLine": 2
										}
									}
									],
									"line_range": {
									"endLine": 7,
									"startLine": 1
									}
									}
									]
	count(result) == 1
}
