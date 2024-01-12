# METADATA
# title: "Restrictive Security Group Rules Enforcement"
# description: "This policy ensures that security groups do not contain overly permissive allow-all rules, reducing the risk of unauthorized access and potential security breaches."
# related_resources:
# - https://registry.terraform.io/providers/webbankir/yandex/latest/docs/resources/vpc_security_group
# custom:
#   id: CB_TFYC_019
#   severity: MEDIUM
package lib.terraform.CB_TFYC_019

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"yandex_vpc_security_group" in block.Labels
}

resource[resource] {
	some block in pass
	resource := concat(".", block.Labels)
}

resource[resource] {
	some block in fail
	resource := concat(".", block.Labels)
}

fail[resource] {
	some resource in input
	isvalid(resource)
	some block in resource.Blocks
	block.Type == "ingress"
	some cidr_block in block.Attributes.v4_cidr_blocks
	cidr_block == "0.0.0.0/0"
	to_number(block.Attributes.port) == -1
}

fail[resource] {
	some resource in input
	isvalid(resource)
	some block in resource.Blocks
	block.Type == "ingress"
	some cidr_block in block.Attributes.v4_cidr_blocks
	cidr_block == "0.0.0.0/0"
	not block.Attributes.from_port
	not block.Attributes.to_port
}

fail[resource] {
	some resource in input
	isvalid(resource)
	some block in resource.Blocks
	block.Type == "ingress"
	some cidr_block in block.Attributes.v4_cidr_blocks
	cidr_block == "0.0.0.0/0"
	block.Attributes.from_port == 0
	block.Attributes.to_port == 65535
}

pass[resource] {
	some resource in input
	isvalid(resource)
	not fail[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "Security group rules are appropriately configured without overly permissive allow-all rules, promoting a secure network environment.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The security group contains allow-all rules, posing a potential security risk. It is recommended to restrict rules to necessary and specific IP ranges for enhanced security.",
		"snippet": block,
	}
}
