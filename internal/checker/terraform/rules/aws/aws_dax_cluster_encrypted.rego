# METADATA
# title: "Check to see if DAX is encrypted at rest (the default is unencrypted)."
# description: "For the purpose of managing the single service default key used to encrypt clusters, DAX encryption at rest seamlessly connects with AWS KMS."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dax_cluster
# custom:
#   id: CB_TFAWS_041
#   severity: HIGH
package lib.terraform.CB_TFAWS_041

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_dax_cluster"
}

resource contains resource if {
	some block in pass
	resource := concat(".", block.Labels)
}

resource contains resource if {
	some block in fail
	resource := concat(".", block.Labels)
}

pass contains resource if {
	some resource in input
	isvalid(resource)
	some block in resource.Blocks
	block.Type == "server_side_encryption"
	block.Attributes.enabled == true
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "aws_dax_cluster_encrypted is set to true.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "aws_dax_cluster_encrypted should be set to true.",
		"snippet": block,
	}
}