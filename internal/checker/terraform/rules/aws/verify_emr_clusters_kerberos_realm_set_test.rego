package lib.terraform.CB_TFAWS_103

test_emr_cluster_kerberos_realm_set {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_emr_cluster",
			"test",
		],
		"Attributes": {},
		"Blocks": [{
			"Type": "kerberos_attributes",
			"Labels": [],
			"Attributes": {
				"kdc_admin_password": "somePassword",
				"realm": "EC2.INTERNAL",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 6,
				"startLine": 3,
			},
		}],
		"line_range": {
			"endLine": 7,
			"startLine": 1,
		},
	}]

	count(result) == 1
}

test_emr_cluster_kerberos_realm_not_set {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_emr_cluster",
			"test",
		],
		"Attributes": {},
		"Blocks": [{
			"Type": "kerberos_attributes",
			"Labels": [],
			"Attributes": {"kdc_admin_password": "somePassword"},
			"Blocks": [],
			"line_range": {
				"endLine": 6,
				"startLine": 3,
			},
		}],
		"line_range": {
			"endLine": 7,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
