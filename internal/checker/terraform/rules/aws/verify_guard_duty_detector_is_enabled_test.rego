package lib.terraform.CB_TFAWS_227
import rego.v1

test_verify_guard_duty_detector_is_enabled_passed if {
	result := passed with input as [
									{
									"Type": "resource",
									"Labels": [
									"aws_guardduty_detector",
									"pass"
									],
									"Attributes": {
									"enable": true
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

test_verify_guard_duty_detector_is_enabled_failed if {
	result := failed with input as [
									{
									"Type": "resource",
									"Labels": [
									"aws_guardduty_detector",
									"pass"
									],
									"Attributes": {
									"enable": false
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
