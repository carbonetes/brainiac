# METADATA
# title: "Verify offering is using HTTPS protocol"
# description: "This policy ensures offering use HTTPS for secure communication, guarding against vulnerabilities linked to unsecured protocols. It guarantees encrypted data transmission, shielding against unauthorized access or interception, and upholds a secure, compliant infrastructure environment."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/cm_offering
# custom:
#   id: CB_TFIBM_014
#   severity: MEDIUM
package lib.terraform.CB_TFIBM_014

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	supported_resource := ["ibm_cm_offering", "cm_offering"]
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

media_url(block) if {
    block.Type == "media"
    attribute := block.Attributes
    is_valid(attribute.url)
    is_valid(attribute.api_url)
    is_valid(attribute.thumbnail_url)
    some blocks in block.Blocks
    blocks.Type == "url_proxy"
    attributes := blocks.Attributes
    is_valid(attributes.url)
}

pass contains resource if {
	some resource in input
	isvalid(resource)
	is_valid(resource.Attributes.offering_docs_url)
	is_valid(resource.Attributes.offering_icon_url)
	some block in resource.Blocks
	media_url(block)
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "Offering is using HTTPS protocol",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Offering is not using HTTPS protocol",
		"snippet": block,
	}
}