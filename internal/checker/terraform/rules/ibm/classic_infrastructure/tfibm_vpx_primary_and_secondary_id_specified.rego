# METADATA
# title: "Verify vpx primary and secodary id are specified"
# description: "This policy ensures that both the primary_id and secondary_id fields are provided with values and are not left empty. If either of these fields is empty, a violation is triggered with a corresponding message indicating which field must be specified. By enforcing this policy, it helps maintain data integrity and prevents potential errors or unexpected behavior in downstream processes reliant on these identifiers."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/lb_vpx_ha
# custom:
#   id: CB_TFIBM_001
#   severity: MEDIUM
package lib.terraform.CB_TFIBM_001

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	supported_resource := ["ibm_lb_vpx_ha", "test_ha"]
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

second(attribute) if {
	attribute.secondary_id != ""
}

pass contains resource if {
	some resource in input
	isvalid(resource)
	attribute := resource.Attributes
    "primary_id" in object.keys(attribute)
    "secondary_id" in object.keys(attribute)
    second(attribute)
    attribute.primary_id != ""
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "VPX primary and secondary id is specified",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "VPX primary or secondary id must be specified",
		"snippet": block,
	}
}