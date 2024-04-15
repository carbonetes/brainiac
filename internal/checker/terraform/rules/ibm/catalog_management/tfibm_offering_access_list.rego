# METADATA
# title: "Verify share access list is valid"
# description: "This policy requires validation of the share access list to ensure accuracy, proper formatting, and alignment with access control standards for authorized access to shared resources. Identifying and mitigating potential vulnerabilities through this meticulous process enhances the system's security posture."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/cm_offering
# custom:
#   id: CB_TFIBM_016
#   severity: LOW
package lib.terraform.CB_TFIBM_016

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

is_valid(value) if {
    startswith(value, "-ent-")
}

is_valid(value) if {
    startswith(value, "-entgrp-")
}

fail contains resource if {
    some resource in input
    attribute := resource.Attributes
    some value in attribute.share_with_access_list
    not is_valid(value)
}

pass contains block if {
	some block in input
	isvalid(block)
	not fail[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "Share access list is valid",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Share access list is not valid",
		"snippet": block,
	}
}
