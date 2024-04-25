# METADATA
# title: "Verify virtual guest member template contains ssh key ID"
# description: "This policy ensures that SSH keys are securely managed within the environment. It denies configurations where SSH keys are not present in the list of authorized keys. The violation message specifies the SSH key ID that is not authorized, prompting action to rectify the unauthorized key usage."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/compute_autoscale_group
# custom:
#   id: CB_TFIBM_043
#   severity: MEDIUM
package lib.terraform.CB_TFIBM_043

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	supported_resource := ["ibm_compute_autoscale_group", "test_scale_group"]
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

https(attribute) if {
	attribute.https_port >= 0
}

pass contains resource if {
	some resource in input
	isvalid(resource)
	attribute := resource.Attributes
	virtual := attribute.virtual_guest_member_template
	"ssh_key_ids" in object.keys(virtual)
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "Virtual guest member template contains SSH key id",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Virtual guest member template does not contain SSH key id",
		"snippet": block,
	}
}