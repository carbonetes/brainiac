# METADATA
# title: "Guarantee that the data stored within the Redshift cluster is adequately encrypted when it is at rest"
# description: "It is advised to encrypt all data stored within the Redshift cluster to ensure its security while at rest."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/redshift_cluster
# custom:
#   id: CB_TFAWS_062
#   severity: HIGH
package lib.terraform.CB_TFAWS_062

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
	isvalid(resource)
	resource.Attributes.encrypted == true
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "Data that is saved within the Redshift cluster is encrypted.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Data that is saved within the Redshift cluster should be encrypted.",
		"snippet": block,
	}
}
