# METADATA
# title: "Verify MSK Cluster encryption in rest and transit is enabled"
# description: "By enabling both encryption at rest and in transit for your MSK cluster, you significantly enhance the security posture of your Kafka infrastructure."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/msk_cluster.html
# custom:
#   id: CB_TFAWS_093
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_093

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

fail contains resource if {
	some resource in input
	isvalid(resource)
	some block in resource.Blocks
	block.Type == "encryption_info"
	some blocks in block.Blocks
	blocks.Type == "encryption_in_transit"
	blocks.Attributes.client_broker != "TLS"
}

fail contains resource if {
	some resource in input
	isvalid(resource)
	some block in resource.Blocks
	block.Type == "encryption_info"
	some blocks in block.Blocks
	blocks.Type == "encryption_in_transit"
	blocks.Attributes.in_cluster == false
}

pass contains block if {
	some block in input
	isvalid(block)
	not fail[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "'aws_msk_cluster' encryption is set properly",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "'aws_msk_cluster' encryption should be set properly at rest and transit",
		"snippet": block,
	}
}
