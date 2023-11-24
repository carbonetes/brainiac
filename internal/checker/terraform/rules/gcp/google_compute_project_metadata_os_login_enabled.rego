# METADATA
# title: "Verify 'OS Login' is enabled for a Project"
# description: "This policy checks whether 'OS Login' is enabled for a Google Cloud Platform project. Enabling 'OS Login' enhances security by providing a centralized and secure way to manage access to VM instances."
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_project_metadata
# custom:
#   id: CB_TFGCP_070
#   severity: MEDIUM
package lib.terraform.CB_TFGCP_070

import future.keywords.in
import future.keywords.if

isvalid(block) {
	block.Type == "resource"
	"google_compute_project_metadata" in block.Labels
}

resource[resource] {
	some block in pass
	resource := concat(".", block.Labels)
}

resource[resource] {
	some block in fail
	resource := concat(".", block.Labels)
}

pass[resource] {
	some resource in input
	isvalid(resource)
    metadata := resource.Attributes.metadata
    "enable-oslogin" in object.keys(metadata)
    metadata_equals_to_true(metadata)
}

metadata_equals_to_true(metadata) := true if {
    metadata["enable-oslogin"] == "TRUE"
} else {
    metadata["enable-oslogin"] == true
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "'OS Login' is correctly enabled for the Project, enhancing security and access control.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "'OS Login' is not enabled for the Project, posing a security risk. Enable 'OS Login' to enhance access control and security for VM instances.",
		"snippet": block,
	}
}
