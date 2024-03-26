# METADATA
# title: "Guarantee the privacy of MSK nodes"
# description: "This check ensures that the nodes in Amazon Managed Streaming for Apache Kafka are configured as private to enhance the security and prevent unauthorized access to the cluster."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/msk_cluster
# custom:
#   id: CB_TFAWS_270
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_270

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_msk_cluster"
}

resource contains resource if {
	some block in pass
	resource := concat(".", block.Labels)
}

resource contains resource if {
	some block in fail
	resource := concat(".", block.Labels)
}

pass contains block if {
	some block in input
	isvalid(block)
	not fail[block]
}

fail contains resource if {
	some resource in input
	isvalid(resource)
	resource.Blocks[_].Type == "broker_node_group_info"
	resource.Blocks[_].Blocks[_].Type == "connectivity_info"
	resource.Blocks[_].Blocks[_].Blocks[_].Type == "public_access"
	resource.Blocks[_].Blocks[_].Blocks[_].Attributes.type == "SERVICE_PROVIDED_EIPS"
}

passed contains result if {
	some block in pass
	result := {
		"message": "MSK nodes are configured as private.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "MSK nodes must be configured as private.",
		"snippet": block,
	}
}
