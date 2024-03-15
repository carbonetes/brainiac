# METADATA
# title: "Verify Minimum App Service Instances for Failover"
# description: "This policy ensures that the App Service is configured with a minimum number of instances to support failover and high availability."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/service_plan
# custom:
#   id: CB_TFAZR_210
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_210

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"azurerm_service_plan" in block.Labels
}

resource[resource] {
	some block in pass
	resource := concat(".", block.Labels)
}

resource[resource] {
	some block in fail
	resource := concat(".", block.Labels)
}

pass[resource] {
	some resource in input
	isvalid(resource)
	to_number(resource.Attributes.worker_count) >= 1
}

pass[resource] {
	some resource in input
	isvalid(resource)
	is_number(resource.Attributes.worker_count)
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "The App Service has the required minimum number of instances, enhancing failover capability.",
		"snippet": block, 
    }
}

failed[result] {
	some block in fail
	result := {
		"message": "The App Service does not meet the minimum instance requirements for failover. Review and adjust the configuration for improved high availability.",
		"snippet": block, 
    }
}
