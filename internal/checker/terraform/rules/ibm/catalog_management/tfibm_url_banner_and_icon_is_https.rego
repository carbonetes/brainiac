# METADATA
# title: "Verify URLs for both icon and banner is HTTPS"
# description: "This policy is designed to enhance data security by enforcing the utilization of the HTTPS protocol for URLs linked to both icons and banners. By requiring the use of HTTPS, the policy aims to mitigate potential risks associated with insecure data transmission over the internet."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/cm_catalog
# custom:
#   id: CB_TFIBM_004
#   severity: LOW
package lib.terraform.CB_TFIBM_004

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	supported_resource := ["ibm_cm_catalog", "cm_catalog"]
	label in supported_resource
}

resource contains resource if {
	some block in pass
	resource := concat(".", block.Labels)
}

resource contains resource if {
	some block in fail
	resource := concat(".", block.Labels)
}

is_valid(url) if {
	startswith(url, "https://")
}

pass contains resource if {
	some resource in input
	is_valid(resource.Attributes.catalog_icon_url)
	is_valid(resource.Attributes.catalog_banner_url)
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "URLs for both the icon and banner is using HTTPS protocol",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "URLs on icon or banner is not HTTPS",
		"snippet": block,
	}
}