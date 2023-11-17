# METADATA
# title: "Verify AUTH is Enabled for Memorystore Redis"
# description: "This check ensures that authentication (AUTH) is enabled for Google Cloud Memorystore for Redis instances. Enabling AUTH adds a layer of security by requiring clients to authenticate before accessing Redis services, protecting against unauthorized access."
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/redis_instance
# custom:
#   id: CB_TFGCP_099
#   severity: MEDIUM
package lib.terraform.CB_TFGCP_099

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
	resource.Attributes.auth_enabled == true
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "Authentication (AUTH) is enabled for the Memorystore for Redis instance, enhancing security and access control.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Authentication (AUTH) is not enabled for the Memorystore for Redis instance, posing a security risk due to potential unauthorized access.",
		"snippet": block,
	}
}
