package lib.terraform.CB_TFDIO_004

test_digitalocean_firewall_ingress_not_open_passed {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"digitalocean_firewall",
			"example",
		],
		"Attributes": {"name": "example-firewall"},
		"Blocks": [{
			"Type": "inbound_rule",
			"Labels": [],
			"Attributes": {
				"port_range": "22",
				"protocol": "tcp",
				"source_addresses": ["trusted_ip"],
			},
			"Blocks": [],
			"line_range": {
				"endLine": 8,
				"startLine": 4,
			},
		}],
		"line_range": {
			"endLine": 13,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_digitalocean_firewall_ingress_not_open_failed {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"digitalocean_firewall",
			"example",
		],
		"Attributes": {"name": "example-firewall"},
		"Blocks": [{
			"Type": "inbound_rule",
			"Labels": [],
			"Attributes": {
				"port_range": "22",
				"protocol": "tcp",
				"source_addresses": [
					"0.0.0.0/0",
					"::/0",
				],
			},
			"Blocks": [],
			"line_range": {
				"endLine": 8,
				"startLine": 4,
			},
		}],
		"line_range": {
			"endLine": 13,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
