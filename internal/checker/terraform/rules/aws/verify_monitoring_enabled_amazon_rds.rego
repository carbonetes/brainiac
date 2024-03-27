# METADATA
# title: "Verify that enhanced monitoring is enabled for Amazon RDS instances"
# description: "By enabling enhanced monitoring, you can collect and analyze additional metrics at a higher resolution, which helps in identifying performance bottlenecks, troubleshooting issues, and optimizing the database performance."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster_instance.html
# custom:
#   id: CB_TFAWS_109
#   severity: LOW
package lib.terraform.CB_TFAWS_109

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

has_attribute(key, value) if {
	value in object.keys(key)
}

pass contains resource if {
	some resource in input
	isvalid(resource)
	has_attribute(resource.Attributes, "monitoring_interval")
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "'Amazon RDS instances' monitoring_interval is configured",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "'Amazon RDS instances' monitoring_interval should be configured.",
		"snippet": block,
	}
}
