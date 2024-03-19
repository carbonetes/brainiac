package lib.azurearm.CB_AZR_019

test_azr_standard_pricing_tier_selected {
	result := passed with input as {
        "resources": [
            {
                "type": "Microsoft.Security/pricings",
                "name": "exampleSecurityPricing",
                "properties": {
                    "pricingTier": "Standard"
                }
            }
        ]
    }
	count(result) == 1
}

test_azr_standard_pricing_tier_not_selected {
	result := failed with input as {
        "resources": [
            {
                "type": "Microsoft.Security/pricings",
                "name": "exampleSecurityPricing",
                "properties": {
                    "pricingTier": "Free"
                }
            }
        ]
    }
	count(result) == 1
}