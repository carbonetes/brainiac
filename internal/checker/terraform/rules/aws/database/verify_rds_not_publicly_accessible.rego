# METADATA
# title: "Verify all data stored in RDS is not publicly accessible"
# description: "This helps to ensure data confidentiality, integrity, and availability. "
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance#publicly_accessible
# custom:
#   id: CB_TFAWS_021
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_021

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	supportedresource := ["aws_db_instance", "aws_rds_cluster_instance"]
	label in supportedresource
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
    resource.Attributes.publicly_accessible == true
}

pass contains block if {
	some block in input
	isvalid(block)
	not fail[block]
}

passed contains result if {
	some block in pass
	result := { "message": "'aws_db_instance' 'publicly_accessible' is set properly.",
                "snippet": block }
}

failed contains result if {
	some block in fail
	result := { "message": "'aws_db_instance' 'publicly_accessible' should be set to false",
                "snippet": block }
} 