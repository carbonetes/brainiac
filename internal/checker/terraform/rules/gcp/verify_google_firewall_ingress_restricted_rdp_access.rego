# METADATA
# title: "Verify Google compute firewall ingress does not allow unrestricted rdp access"
# description: "This check verifies that Google Compute Engine firewall rules for RDP access are not overly permissive, preventing unrestricted and potentially insecure RDP access to instances."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall
# custom:
#   id: CB_TFGCP_008
#   severity: CRITICAL
package lib.terraform.CB_TFGCP_008
import future.keywords.in

isvalid(block){
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
	"3389" in inner_block.Attributes.ports
}

pass[block] {
    some block in input
	isvalid(block)
    not fail[block]
}


passed[result] {
    some block in pass
	result := { "message": "Google compute firewall ingress does not allow unrestricted rdp access.",
                "snippet": block }
}

failed[result] {
    some block in fail
	result := { "message": "Google compute firewall ingress should not allow unrestricted rdp access.",
                "snippet": block }
}