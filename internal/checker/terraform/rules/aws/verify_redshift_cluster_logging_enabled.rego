# METADATA
# title: "Verify Redshift Cluster logging is enabled"
# description: "Enabling Redshift Cluster logging ensures that important information about the cluster's activities, queries, errors, and performance metrics is captured and stored for analysis. "
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/redshift_cluster
# custom:
#   id: CB_TFAWS_078
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_078

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
	some block in resource.Blocks
	block.Type == "logging"
	block.Attributes.enable == true
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "'aws_redshift_cluster' 'logging' is enabled.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "'aws_redshift_cluster' 'logging' should be enabled.",
		"snippet": block,
	}
}
