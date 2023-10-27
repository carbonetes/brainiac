# METADATA
# title: "Verify Azure Container Registry (ACR) Enforces HTTPS for Webhooks"
# description: "This policy ensures that Azure Container Registry (ACR) enforces HTTPS for its webhooks to enhance security and data integrity."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry_webhook
# custom:
#   id: CB_TFAZR_228
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_228

import future.keywords.in

isvalid(resource) {
	resource.Type == "resource"
	"azurerm_container_registry_webhook" in resource.Labels
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
    startswith(resource.Attributes.service_uri, "https://")
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "Azure Container Registry (ACR) enforces HTTPS for webhooks, enhancing security.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Azure Container Registry (ACR) does not enforce HTTPS for webhooks, posing a security risk.",
		"snippet": block,
	}
}