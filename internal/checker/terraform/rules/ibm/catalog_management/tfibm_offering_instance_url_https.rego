# METADATA
# title: "Verify URL in offering instance is secured"
# description: "This policy ensures that URLs associated with IBM Cloud offering instances use HTTPS, ensuring encrypted communication. By enforcing this, it protects sensitive data from interception, tampering, and unauthorized access, maintaining system security."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/cm_offering_instance
# custom:
#   id: CB_TFIBM_022
#   severity: HIGH
package lib.terraform.CB_TFIBM_022

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	supported_resource := ["ibm_cm_offering_instance", "cm_offering_instance"]
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
	is_valid(resource.Attributes.url)
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "Offering instance URL is HTTPS",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Offering instance URL should be HTTPS",
		"snippet": block,
	}
}
