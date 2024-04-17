# METADATA
# title: "Verify HTTPS url usage in provisioning hook resource"
# description: "This policy ensures all URLs in Terraform resources use HTTPS. It validates each resource's URI attribute to enforce secure communication practices, reducing the risk of data compromise."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/compute_provisioning_hook
# custom:
#   id: CB_TFIBM_047
#   severity: LOW
package lib.terraform.CB_TFIBM_047

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	supported_resource := ["ibm_compute_provisioning_hook", "test_provisioning_hook"]
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
	isvalid(resource)
	attribute := resource.Attributes
	is_valid(attribute.uri)
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "URL is secure",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "URL is not secure",
		"snippet": block,
	}
}