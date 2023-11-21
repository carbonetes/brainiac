# METADATA
# title: "Guarantee that the Google Cloud Platform (GCP) compute firewall ingress configurations prohibit unrestricted access to every port"
# description: "Verify that Google Cloud Platform (GCP) compute firewall ingress settings limit access to specific ports, preventing unrestricted entry to every port for enhanced security."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall
# custom:
#   id: CB_TFGCP_113
#   severity: HIGH
package lib.terraform.CB_TFGCP_113

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

fail[block] {
	some block in input
	isvalid(block)
	some inner_block in block.Blocks
	inner_block.Type == "allow"
	inner_block.Attributes.protocol == "all"
}

pass[block] {
	some block in input
	isvalid(block)
	not fail[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "The Google Cloud Platform (GCP) compute firewall ingress configurations prohibit unrestricted access to every port.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The Google Cloud Platform (GCP) compute firewall ingress configurations must prohibit unrestricted access to every port.",
		"snippet": block,
	}
}
