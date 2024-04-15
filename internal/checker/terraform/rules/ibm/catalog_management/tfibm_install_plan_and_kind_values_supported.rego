# METADATA
# title: "Verify Install plan and kind format values is supported"
# description: "This policy helps maintain consistency and compatibility with the supported configurations, ensuring proper functionality and management of IBM Cloud offering instances. Compliance with this policy guarantees that only valid and supported values are used for the install plan and kind format, minimizing potential errors and ensuring smooth operations."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/cm_offering_instance
# custom:
#   id: CB_TFIBM_023
#   severity: LOW
package lib.terraform.CB_TFIBM_023

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

pass contains resource if {
	some resource in input
	attribute := resource.Attributes	
    value1 := ["Automatic", "Manual"]
    attribute.install_plan in value1
    kind(attribute)
}

kind(attribute) if {
    value2 := ["operator", "operator-bundle"]
    attribute.kind_format in value2
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "Install plan and kind values are supported",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Values not supported",
		"snippet": block,
	}
}