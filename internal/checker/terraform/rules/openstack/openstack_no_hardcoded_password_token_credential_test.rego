package lib.terraform.CB_TFOPENSTACK_001

test_openstack_no_hardcoded_password_token_credential_passed {
	result := passed with input as [
		{
			"Type": "provider",
			"Labels": ["openstack"],
			"Attributes": {
				"application_credential_secret": "var.openstack_application_credential_secret",
				"password": "var.openstack_password",
				"token": "var.openstack_token",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 7,
				"startLine": 1,
			},
		},
		{
			"Type": "variable",
			"Labels": ["openstack_password"],
			"Attributes": {
				"description": "OpenStack password",
				"type": "string",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 13,
				"startLine": 10,
			},
		},
		{
			"Type": "variable",
			"Labels": ["openstack_token"],
			"Attributes": {
				"description": "OpenStack token",
				"type": "string",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 18,
				"startLine": 15,
			},
		},
		{
			"Type": "variable",
			"Labels": ["openstack_application_credential_secret"],
			"Attributes": {
				"description": "OpenStack application credential secret",
				"type": "string",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 23,
				"startLine": 20,
			},
		},
	]
	count(result) == 1
}

test_openstack_no_hardcoded_password_token_credential_failed {
	result := failed with input as [
		{
			"Type": "provider",
			"Labels": ["openstack"],
			"Attributes": {
				"application_credential_secret": "hardcoded_sample",
				"password": "hardcoded_sample",
				"token": "hardcoded_sample",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 7,
				"startLine": 1,
			},
		},
		{
			"Type": "variable",
			"Labels": ["openstack_password"],
			"Attributes": {
				"description": "OpenStack password",
				"type": "string",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 13,
				"startLine": 10,
			},
		},
		{
			"Type": "variable",
			"Labels": ["openstack_token"],
			"Attributes": {
				"description": "OpenStack token",
				"type": "string",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 18,
				"startLine": 15,
			},
		},
		{
			"Type": "variable",
			"Labels": ["openstack_application_credential_secret"],
			"Attributes": {
				"description": "OpenStack application credential secret",
				"type": "string",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 23,
				"startLine": 20,
			},
		},
	]
	count(result) == 1
}
