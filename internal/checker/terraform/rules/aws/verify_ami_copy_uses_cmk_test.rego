package lib.terraform.CB_TFAWS_225
import rego.v1

test_verify_ami_copy_uses_cmk_passed if {
	result := passed with input as [
									{
									"Type": "resource",
									"Labels": [
									"aws_ami_copy",
									"pass"
									],
									"Attributes": {
									"kms_key_id": "aws_kms_key.copy.arn"
									},
									"Blocks": [],
									"line_range": {
									"endLine": 3,
									"startLine": 1
									}
									}
									]
	count(result) == 1
}

test_verify_ami_copy_uses_cmk_failed if {
	result := failed with input as [
									{
									"Type": "resource",
									"Labels": [
									"aws_ami_copy",
									"pass"
									],
									"Attributes": {
									"kms_key_id": ""
									},
									"Blocks": [],
									"line_range": {
									"endLine": 3,
									"startLine": 1
									}
									}
									]
	count(result) == 1
}
