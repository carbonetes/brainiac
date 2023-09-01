package lib.terraform.CB_TFAWS_223

test_verify_ami_copy_is_encrypted_passed {
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

test_verify_ami_copy_is_encrypted_failed {
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
