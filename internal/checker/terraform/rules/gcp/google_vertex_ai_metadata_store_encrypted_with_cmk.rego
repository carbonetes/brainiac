# METADATA
# title: "Verify Vertex AI Metadata Store uses a Customer Managed Key (CMK)"
# description: "This policy ensures that Vertex AI Metadata Store is configured to use a Customer Managed Key (CMK) for encryption, providing additional control over the key management process."
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/vertex_ai_metadata_store
# custom:
#   id: CB_TFGCP_100
#   severity: LOW
package lib.terraform.CB_TFGCP_100

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"google_vertex_ai_metadata_store" in block.Labels
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
		"message": "The Vertex AI Metadata Store is configured to use a Customer Managed Key (CMK) for encryption, enhancing key management control.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The Vertex AI Metadata Store does not use a Customer Managed Key (CMK) for encryption, posing a potential security risk. Update the configuration to enable CMK for enhanced key management control.",
		"snippet": block,
	}
}
