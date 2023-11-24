# METADATA
# title: "Verify Memorystore for Redis Enforces In-Transit Encryption"
# description: "This policy ensures that Vertex AI Metadata Store is configured to use a Customer Managed Key (CMK) for encryption, providing additional control over the key management process."
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/redis_instance
# custom:
#   id: CB_TFGCP_101
#   severity: LOW
package lib.terraform.CB_TFGCP_101

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"google_redis_instance" in block.Labels
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
	resource.Attributes.transit_encryption_mode == "SERVER_AUTHENTICATION"
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "Memorystore for Redis enforces in-transit encryption, enhancing the security of data transfer.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "In-transit encryption is not enabled for Memorystore for Redis, potentially exposing data during transfer. Update the configuration to enforce in-transit encryption for improved security.",
		"snippet": block,
	}
}
