# METADATA
# title: "Verify Vertex AI datasets use a CMK (Customer Managed Key)"
# description: "Ensure that Vertex AI datasets are configured to use a Customer Managed Key (CMK) for encryption. Using CMKs allows customers to have greater control and management over their encryption keys, enhancing security."
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/vertex_ai_dataset
# custom:
#   id: CB_TFGCP_096
#   severity: LOW
package lib.terraform.CB_TFGCP_096

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"google_vertex_ai_dataset" in block.Labels
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
	some block in resource.Blocks
	block.Type == "encryption_spec"
	block.Attributes.kms_key_name != ""
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "The Vertex AI datasets are configured to use a Customer Managed Key (CMK), ensuring enhanced encryption security.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Vertex AI datasets do not use a Customer Managed Key (CMK), posing a potential security risk due to inadequate encryption measures.",
		"snippet": block,
	}
}