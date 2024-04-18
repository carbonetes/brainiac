# METADATA
# title: "Verify HTTPS protocol in action URL"
# description: "This policy validates that the 'url' in the 'ibm_appid_action_url' resource uses 'https'. It checks if the URL is using a secure protocol."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/appid_action_url
# custom:
#   id: CB_TFIBM_60
#   severity: MEDIUM
package lib.terraform.CB_TFIBM_60

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	"ibm_appid_action_url" in block.Labels
}

pass contains resource if {
	some resource in input
	isvalid(resource)
	hasSecureUrl(resource)
}

fail contains resource if {
	some resource in input
	isvalid(resource)
	not hasSecureUrl(resource)
}

hasSecureUrl(block) if {
	startswith(block.Attributes.url, "https")
}

passed contains result if {
	some block in pass
	result := {
		"message": "IBM AppID Action URL resource is using a secure URL.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "IBM AppID Action URL resource is not using a secure URL.",
		"snippet": block,
	}
}
