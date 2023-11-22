# METADATA
# title: "Verify GCP network defines a firewall and does not use the default firewall"
# description: "This security measure ensures that a specific Google Cloud Platform (GCP) network has a defined firewall configuration tailored to specific requirements, avoiding reliance on the default and potentially less restrictive firewall settings."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_network
# custom:
#   id: CB_TFGCP_128
#   severity: MEDIUM
package lib.terraform.CB_TFGCP_128

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"google_compute_network" in block.Labels
}

resource[resource] {
	some block in pass
	resource := concat(".", block.Labels)
}

resource[resource] {
	some block in fail
	resource := concat(".", block.Labels)
}

label_for_network[label] {
	some block in input
	block.Type == "resource"
	"google_compute_network" in block.Labels
	label := concat(".", block.Labels)
}

firewall_connected{
	some block in input
	block.Type == "resource"
	"google_compute_firewall" in block.Labels
	some label in label_for_network
	contains(block.Attributes.network, label)
}

pass[block] {
	some block in input
    isvalid(block)
	firewall_connected
}


fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}
passed[result] {
	some block in pass
	result := {
		"message": "GCP network defines a firewall and does not use the default firewall.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "GCP network should define a firewall and not use the default firewall.",
		"snippet": block,
	}
}
