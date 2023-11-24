# METADATA
# title: "Verify that RSASHA1 is not used for the zone-signing and key-signing keys in Cloud DNS DNSSECS"
# description: "This security measure involves replacing RSASHA1 with more robust algorithms, bolstering the integrity and authenticity of your DNS data, and reducing the risk of cryptographic vulnerabilities."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/dns_managed_zone
# custom:
#   id: CB_TFGCP_036
#   severity: MEDIUM
package lib.terraform.CB_TFGCP_036
import future.keywords.in

isvalid(block){
	block.Type == "resource"
    "google_dns_managed_zone" in block.Labels
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
	inner_block.Type == "zone_signing_keys"
	inner_block.Attributes.algorithm == "rsasha1"
}


pass[block] {
    some block in input
	isvalid(block)
    not fail[block]
}


passed[result] {
    some block in pass
	result := { "message": "RSASHA1 is not used for the zone-signing and key-signing keys in Cloud DNS DNSSECS.",
                "snippet": block }
}

failed[result] {
    some block in fail
	result := { "message": "RSASHA1 should not used for the zone-signing and key-signing keys in Cloud DNS DNSSECS",
                "snippet": block }
}