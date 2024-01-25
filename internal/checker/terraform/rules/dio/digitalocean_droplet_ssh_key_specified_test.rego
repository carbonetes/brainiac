package lib.terraform.CB_TFDIO_002

test_digitalocean_droplet_ssh_key_specified_passed {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"digitalocean_droplet",
			"example",
		],
		"Attributes": {
			"image": "ubuntu-18-04-x64",
			"name": "example-droplet",
			"region": "nyc3",
			"size": "s-1vcpu-1gb",
			"ssh_keys": ["your_ssh_key_here"],
		},
		"Blocks": [],
		"line_range": {
			"endLine": 7,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_digitalocean_droplet_ssh_key_specified_failed {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"digitalocean_droplet",
			"example",
		],
		"Attributes": {
			"image": "ubuntu-18-04-x64",
			"name": "example-droplet",
			"region": "nyc3",
			"size": "s-1vcpu-1gb",
			"ssh_keys": [],
		},
		"Blocks": [],
		"line_range": {
			"endLine": 7,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
