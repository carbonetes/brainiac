package lib.terraform.CB_TFAWS_195
import rego.v1

test_rds_uses_modern_cacert if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_db_instance",
			"pass",
		],
		"Attributes": {"ca_cert_identifier": "rds-ca-2019"},
		"Blocks": [],
		"line_range": {
			"endLine": 3,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_rds_using_modern_cacert if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_db_instance",
			"pass",
		],
		"Attributes": {"ca_cert_identifier": "rds-ca-2018"},
		"Blocks": [],
		"line_range": {
			"endLine": 3,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
