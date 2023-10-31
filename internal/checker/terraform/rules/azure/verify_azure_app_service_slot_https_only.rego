# METADATA
# title: "Verify web app redirects all HTTP traffic to HTTPS in Azure App Service Slot"
# description: "This policy is designed to enhance the security and compliance of web applications hosted on Azure App Service Slots by verifying that all HTTP traffic is redirected to HTTPS."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service_slot
# custom:
#   id: CB_TFAZR_159
#   severity: LOW
package lib.terraform.CB_TFAZR_159

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"azurerm_app_service_slot" in block.Labels
}

resource[resource] {
	some block in pass
	resource := concat(".", block.Labels)
}

resource[resource] {
	some block in fail
	resource := concat(".", block.Labels)
}

pass[block] {
	some block in input
	isvalid(block)
	block.Attributes.https_only == true
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "All HTTP traffic is redirected to HTTPS in the Azure App Service Slot.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "HTTP traffic is not redirected to HTTPS in the Azure App Service Slot.",
		"snippet": block,
	}
}
