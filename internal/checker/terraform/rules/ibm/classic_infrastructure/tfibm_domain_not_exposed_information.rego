# METADATA
# title: "Verify sensitive information for domain is not exposed"
# description: "This policy ensures that sensitive information is not exposed for a specified domain. It verifies that the configured domain does not inadvertently expose sensitive data, helping to maintain data security and compliance with privacy regulations."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/compute_dedicated_host
# custom:
#   id: CB_TFIBM_046
#   severity: LOW
package lib.terraform.CB_TFIBM_046

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	supported_resource := ["ibm_compute_dedicated_host", "dedicatedhost"]
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

pass contains resource if {
	some resource in input
	isvalid(resource)
	attribute := resource.Attributes
    attribute.domain == ""
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "Domain does not exposed sensitive information",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Domain does exposed sensitive information",
		"snippet": block,
	}
}