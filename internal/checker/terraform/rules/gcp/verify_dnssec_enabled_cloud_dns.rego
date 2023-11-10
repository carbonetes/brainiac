# METADATA
# title: "Verify that DNSSEC is enabled for Cloud DNS"
# description: "This verification ensures that your domain's DNS records are protected from tampering and unauthorized changes, enhancing overall security and trustworthiness of your online services."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/dns_managed_zone
# custom:
#   id: CB_TFGCP_035
#   severity: MEDIUM
package lib.terraform.CB_TFGCP_035
import future.keywords.in

import future.keywords.if

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

pass[block] {
    some block in input
	isvalid(block)
   	some inner_block in block.Blocks
	inner_block.Type == "dnssec_config"
	inner_block.Attributes.state == "on"
}


fail[block] {
    some block in input
	isvalid(block)
    not pass[block]
}


passed[result] {
    some block in pass
	result := { "message": "DNSSEC is enabled for Cloud DNS.",
                "snippet": block }
}

failed[result] {
    some block in fail
	result := { "message": "DNSSEC should be enabled for Cloud DNS.",
                "snippet": block }
}