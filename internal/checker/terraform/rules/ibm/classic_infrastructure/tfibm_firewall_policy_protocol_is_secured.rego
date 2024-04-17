# METADATA
# title: "Verify firewall policy protocol is secured"
# description: "This policy entails verifying that the firewall protocol is secured, ensuring that only authorized protocols are permitted through the firewall. By scrutinizing the firewall configurations, administrators confirm that stringent measures are in place to safeguard sensitive data and prevent unauthorized access."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/firewall_policy
# custom:
#   id: CB_TFIBM_051
#   severity: HIGH
package lib.terraform.CB_TFIBM_051

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	supported_resource := ["ibm_firewall_policy", "rules"]
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

pass contains resource if {
	some resource in input
	isvalid(resource)
	some block in resource.Blocks
	attribute := block.Attributes
	attribute.action == "permit"
	values := ["tcp", "udp", "icmp", "gre", "pptp", "ah", "esp"]
	attribute.protocol in values
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "Firewall protocol is secure",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Firewall protocol is secure",
		"snippet": block,
	}
}