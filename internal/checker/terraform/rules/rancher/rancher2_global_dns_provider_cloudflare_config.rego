# METADATA
# title: "Verify CloudFlare Domain for Rancher2 Global DNS Provider"
# description: "Policy to verify that the Rancher2 Global DNS Provider configuration includes CloudFlare Domain."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/global_dns_provider
# custom:
#   id: CB_TFRAN_128
#   severity: MEDIUM
package lib.terraform.CB_TFRAN_128

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"rancher2_global_dns_provider" in block.Labels
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
	count(block.Blocks) == 1
	some innerblock in block.Blocks
	not innerblock.Type == "cloudflare_config"
}

fail[block] {
	some block in input
	isvalid(block)
	some innerblock in block.Blocks
	innerblock.Type == "cloudflare_config"
	"api_email" in object.keys(innerblock.Attributes)
	innerblock.Attributes.api_email == ""
}

fail[block] {
	some block in input
	isvalid(block)
	some innerblock in block.Blocks
	innerblock.Type == "cloudflare_config"
	"api_key" in object.keys(innerblock.Attributes)
	innerblock.Attributes.api_key == ""
}

pass[block] {
	some block in input
	isvalid(block)
	not fail[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "All Rancher2 Global DNS Provider configurations include CloudFlare Domain.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Some Rancher2 Global DNS Provider configurations are missing CloudFlare Domain. Please ensure CloudFlare Domain are provided.",
		"snippet": block,
	}
}
