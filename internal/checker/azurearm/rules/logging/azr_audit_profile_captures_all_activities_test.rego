package lib.azurearm.CB_AZR_038

test_azr_audit_profile_captures_all_activities {
	result := passed with input as {
        "resources": [
            {
                "type": "Microsoft.Insights/logprofiles",
                "name": "*",
                "properties": {
                    "categories": [
                        "Write",
                        "Delete",
                        "Action"
                    ]
                }
            }
        ]
    }
	count(result) == 1
}

test_azr_audit_profile_not_captures_all_activities {
	result := failed with input as {
        "resources": [
            {
                "type": "Microsoft.Insights/logprofiles",
                "name": "*",
                "properties": {
                    "categories": [
                    ]
                }
            }
        ]
}
	count(result) == 1
}
