# METADATA
# title: "Verify that Redshift clusters do not use the default database name"
# description: "By specifying a custom database name for Redshift clusters, it is important to ensure better organization, security, and clarity in data management, especially in multi-cluster environments."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/redshift_cluster
# custom:
#   id: CB_TFAWS_308
#   severity: LOW
package lib.terraform.CB_TFAWS_308

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_redshift_cluster"
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
	resource.Attributes.database_name != ""
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "Redshift clusters does not use the default database name.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Redshift clusters must not use the default database name.",
		"snippet": block,
	}
}
