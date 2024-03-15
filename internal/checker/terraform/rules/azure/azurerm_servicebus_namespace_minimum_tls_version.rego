# METADATA
# title: "Verify Azure Service Bus Latest TLS Encryption"
# description: "This policy ensures that Azure Service Bus is configured to use the latest version of TLS encryption to enhance security and protect data during communication."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/servicebus_namespace
# custom:
#   id: CB_TFAZR_201
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_201

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"azurerm_servicebus_namespace" in block.Labels
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
	resource.Attributes.minimum_tls_version == "1.2"
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "Azure Service Bus uses the latest version of TLS encryption, enhancing security.",
		"snippet": block, 
    }
}

failed[result] {
	some block in fail
	result := {
		"message": "Azure Service Bus should be configured to use the latest version of TLS encryption for improved security and data protection during communication.",
		"snippet": block, 
    }
}
