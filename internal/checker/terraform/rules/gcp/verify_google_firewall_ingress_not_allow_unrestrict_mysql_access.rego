# METADATA
# title: "Verify Google compute firewall ingress does not allow unrestricted mysql access"
# description: "This ensures that firewall rules for Google Compute Engine instances are configured to restrict inbound MySQL traffic, enhancing security by preventing unauthorized access to MySQL services."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall
# custom:
#   id: CB_TFGCP_092
#   severity: LOW
package lib.terraform.CB_TFGCP_092
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
	"0.0.0.0/0" in block.Attributes.source_ranges
	some inner_block in block.Blocks
   	inner_block.Type == "allow"
	"3306" in inner_block.Attributes.ports
}

pass[block] {
    some block in input
	isvalid(block)
    not fail[block]
}


passed[result] {
    some block in pass
	result := { "message": "Google compute firewall ingress does not allow unrestricted mysql access.",
                "snippet": block }
}

failed[result] {
    some block in fail
	result := { "message": "Google compute firewall ingress should not allow unrestricted mysql access.",
                "snippet": block }
}