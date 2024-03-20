package lib.azurearm.CB_AZR_027

test_email_service_co_administrator_enabled {
	result := passed with input as {"resources": [{
		"type": "Microsoft.Sql/servers/databases",
		"properties": {
            "state": "Enabled",
			"emailAccountAdmins": "Enabled"
		}
	}]}
	count(result) == 1
}

test_email_service_co_administrator_disabled {
	result := failed with input as {"resources": [{
		"type": "Microsoft.Sql/servers/databases",
		"properties": {
            "state": "Disabled",
			"emailAccountAdmins": "Disabled"
		}
	}]}
	count(result) == 1
}
