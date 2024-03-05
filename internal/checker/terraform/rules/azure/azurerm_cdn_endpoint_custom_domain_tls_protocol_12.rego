# METADATA
# title: "Enforce Latest TLS Encryption Version for Azure CDN Endpoints"
# description: "This policy ensures that Azure CDN endpoints are configured to use the latest version of TLS encryption to enhance security and protect data during communication."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cdn_endpoint_custom_domain
# custom:
#   id: CB_TFAZR_196
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_196

import future.keywords.in
import future.keywords.if

isvalid(block) {
	block.Type == "resource"
	"azurerm_cdn_endpoint_custom_domain" in block.Labels
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
	not fail[resource]
}

fail[resource] {
	some resource in input
	isvalid(resource)
	some block in resource.Blocks
	block.Type == "user_managed_https"
    checkTlsVersion(block)
}

fail[resource] {
	some resource in input
	isvalid(resource)
	some block in resource.Blocks
	block.Type == "cdn_managed_https"
    checkTlsVersion(block)
}

checkTlsVersion(block) if {
	block.Attributes.tls_version == "None"
} else if {
	block.Attributes.tls_version == "TLS10"
}

passed[result] {
	some block in pass
	result := {
		"message": "Azure CDN endpoints use the latest version of TLS encryption, enhancing security.",
		"snippet": block, 
    }
}

failed[result] {
	some block in fail
	result := {
		"message": "Azure CDN endpoints should be configured to use the latest version of TLS encryption for improved security and data protection during communication.",
		"snippet": block, 
    }
}
