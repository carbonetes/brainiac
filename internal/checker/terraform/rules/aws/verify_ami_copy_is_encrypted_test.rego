package lib.terraform.CB_TFAWS_223
import rego.v1

test_verify_ami_copy_is_encrypted_passed if {
	result := passed with input as [
									{
									"Type": "resource",
									"Labels": [
									"aws_ami_copy",
									"pass"
									],
									"Attributes": {
									"encrypted": true
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

test_verify_ami_copy_is_encrypted_failed if {
	result := failed with input as [
									{
									"Type": "resource",
									"Labels": [
									"aws_ami_copy",
									"pass"
									],
									"Attributes": {
									"encrypted": false
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
