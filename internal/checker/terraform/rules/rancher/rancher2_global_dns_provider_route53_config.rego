# METADATA
# title: "Verify Route53 Domain for Rancher2 Global DNS Provider"
# description: "Policy to verify that the Rancher2 Global DNS Provider configuration includes Route53 Domain."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/global_dns_provider
# custom:
#   id: CB_TFRAN_129
#   severity: MEDIUM
package lib.terraform.CB_TFRAN_129

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
	not innerblock.Type == "route53_config"
}

fail[block] {
	some block in input
	isvalid(block)
	count(block.Blocks) == 1
	some innerblock in block.Blocks
	innerblock.Type == "route53_config"
	"access_key" in object.keys(innerblock.Attributes)
	innerblock.Attributes.access_key == ""
}

fail[block] {
	some block in input
	isvalid(block)
	count(block.Blocks) == 1
	some innerblock in block.Blocks
	innerblock.Type == "route53_config"
	"secret_key" in object.keys(innerblock.Attributes)
	innerblock.Attributes.secret_key == ""
}

pass[block] {
	some block in input
	isvalid(block)
	not fail[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "All Rancher2 Global DNS Provider configurations include Route53 Domain.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Some Rancher2 Global DNS Provider configurations are missing Route53 Domain. Please ensure Route53 Domain are provided.",
		"snippet": block,
	}
}
