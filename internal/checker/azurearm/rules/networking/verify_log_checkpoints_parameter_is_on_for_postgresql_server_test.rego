package lib.azurearm.CB_AZR_030

test_log_checkpoints_on {
	result := passed with input as {"resources": [{
		"name": "log_checkpoints",
		"type": "Microsoft.DBforPostgreSQL/servers/configurations",
		"properties": {"value": "ON"},
	}]}

	count(result) == 1
}

test_log_checkpoints_off {
	result := failed with input as {"resources": [{
		"name": "log",
		"type": "Microsoft.DBforPostgreSQL/servers/configurations",
		"properties": {"value": "off"},
	}]}
	count(result) == 1
}
