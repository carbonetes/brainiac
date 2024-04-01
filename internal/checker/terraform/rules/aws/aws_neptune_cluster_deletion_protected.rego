# METADATA
# title: "Verify AWS Neptune cluster deletion protection is enabled"
# description: "Enabling deletion protection adds an additional layer of security, preventing the deletion of Neptune clusters, which can contain valuable and sensitive data."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/neptune_cluster.html#deletion_protection
# custom:
#   id: CB_TFAWS_358
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_358

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_neptune_cluster"
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
	resource.Attributes.deletion_protection == true
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "Neptune deletion protection is enabled.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Neptune deletion protection should be enabled.",
		"snippet": block,
	}
}
