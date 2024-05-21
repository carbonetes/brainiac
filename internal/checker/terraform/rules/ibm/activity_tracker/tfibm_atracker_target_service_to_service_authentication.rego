# METADATA
# title: "Verify service to service authentication configuration"
# description: "This policy validates that if 'service_to_service_enabled' is set to true for the 'ibm_atracker_target' resource, the 'api_key' must not be supplied. Misconfiguration can lead to potential security risks as unnecessary credentials are exposed."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/atracker_target
# custom:
#   id: CB_TFIBM_021
#   severity: MEDIUM
package lib.terraform.CB_TFIBM_021

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	"ibm_atracker_target" in block.Labels
}

resource contains resource if {
	some block in pass
	resource := concat(".", block.Labels)
}

resource contains resource if {
	some block in fail
	resource := concat(".", block.Labels)
}

pass contains resource if {
	some resource in input
	isvalid(resource)
	not fail[resource]
}

fail contains resource if {
	some resource in input
	isvalid(resource)
	hasInvalidServiceToServiceConfig(resource)
}

hasInvalidServiceToServiceConfig(block) if {
	block.Attributes.service_to_service_enabled == true
	block.Attributes.api_key != ""
}

passed contains result if {
	some block in pass
	result := {
		"message": "IBM Atracker Target service-to-service authentication is correctly configured, minimizing potential security risks.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "IBM Atracker Target service-to-service authentication is misconfigured, leading to potential security risks due to unnecessary credential exposure.",
		"snippet": block,
	}
}
