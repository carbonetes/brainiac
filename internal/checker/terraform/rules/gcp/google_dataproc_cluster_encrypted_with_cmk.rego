# METADATA
# title: "Verify Dataproc Cluster Encryption with Customer Supplied Encryption Keys (CSEK)"
# description: "This policy checks whether Dataproc clusters are configured to use Customer Supplied Encryption Keys (CSEK) for encryption. Utilizing CSEK enhances security by allowing customers to manage their encryption keys."
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/dataproc_cluster
# custom:
#   id: CB_TFGCP_095
#   severity: LOW
package lib.terraform.CB_TFGCP_095

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"google_dataproc_cluster" in block.Labels
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
	block.Type == "cluster_config"
	some innerblock in block.Blocks
	innerblock.Type == "encryption_config"
	innerblock.Attributes.kms_key_name != ""
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "Dataproc clusters are configured to use Customer Supplied Encryption Keys (CSEK), providing enhanced security through customer-managed encryption.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Dataproc clusters are not configured to use Customer Supplied Encryption Keys (CSEK), posing a security risk. Update the configuration to enhance encryption key management.",
		"snippet": block,
	}
}
