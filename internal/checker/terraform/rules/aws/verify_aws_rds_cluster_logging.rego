# METADATA
# title: "Verify that RDS Cluster log capture is enabled"
# description: "By enabling log capture for an Amazon RDS Cluster using CloudWatch Logs exports, it becomes crucial to gain insights into database activity, troubleshoot issues, and ensure compliance with auditing and security requirements."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster
# custom:
#   id: CB_TFAWS_312
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_312

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_rds_cluster"
}

has_attribute(key, value) if {
	value in object.keys(key)
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
	has_attribute(resource.Attributes, "enabled_cloudwatch_logs_exports")
	count(resource.Attributes.enabled_cloudwatch_logs_exports) > 0
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "RDS Cluster log capture is enabled.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "RDS Cluster log capture should be enabled.",
		"snippet": block,
	}
}
