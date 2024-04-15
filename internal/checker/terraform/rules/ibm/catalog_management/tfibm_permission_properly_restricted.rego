# METADATA
# title: "Verify permissions are properly restricted"
# description: "This policy ensures that permissions are appropriately restricted within the Terraform configuration. It verifies that only authorized entities have the capability to publish resources, helping to maintain the integrity and security of the system."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/cm_object
# custom:
#   id: CB_TFIBM_008
#   severity: HIGH
package lib.terraform.CB_TFIBM_008

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	supported_resource := ["ibm_cm_object", "cm_object"]
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
	some block in resource.Blocks
	block.Type == "publish"
	attribute := block.Attributes
	attribute.permit_ibm_public_publish != true
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "Permissions are properly restricted",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Permissions is not properly restricted",
		"snippet": block,
	}
}