# METADATA
# title: "Verify Google compute firewall ingress does not allow on ftp port"
# description: "This ensures that the firewall rules in Google Compute Engine do not permit incoming traffic on the FTP (File Transfer Protocol) port."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall
# custom:
#   id: CB_TFGCP_074
#   severity: LOW
package lib.terraform.CB_TFGCP_074
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
	"20" in inner_block.Attributes.ports
}

pass[block] {
    some block in input
	isvalid(block)
    not fail[block]
}


passed[result] {
    some block in pass
	result := { "message": "Google compute firewall ingress does not allow on ftp port.",
                "snippet": block }
}

failed[result] {
    some block in fail
	result := { "message": "Google compute firewall ingress should not allow on ftp port.",
                "snippet": block }
}