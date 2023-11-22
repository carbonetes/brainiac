# METADATA
# title: "Verify Restriction of Ingress HTTP Port 80 in Google Compute Firewall"
# description: "This policy ensures that Google Compute Firewall rules for ingress do not allow unrestricted access to HTTP port 80, enhancing security by limiting potential vulnerabilities."
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall
# custom:
#   id: CB_TFGCP_120
#   severity: LOW
package lib.terraform.CB_TFGCP_120

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"google_compute_firewall" in block.Labels
}

resource[resource] {
	some block in pass
	resource := concat(".", block.Labels)
}

resource[resource] {
	some block in fail
	resource := concat(".", block.Labels)
}

fail[resource] {
	some resource in input
	isvalid(resource)
	some block in resource.Blocks
	block.Type == "allow"
    some port in block.Attributes.ports
	to_number(port) == 80
}

pass[resource] {
	some resource in input
	isvalid(resource)
	not fail[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "Ingress firewall rules for HTTP port 80 are appropriately restricted, enhancing security by preventing unrestricted access.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Ingress firewall rules for HTTP port 80 allow unrestricted access, posing a security risk. Restrict access to enhance the security of your Google Compute resources.",
		"snippet": block,
	}
}
