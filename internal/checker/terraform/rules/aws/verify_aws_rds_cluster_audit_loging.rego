# METADATA
# title: "Verify that RDS Cluster audit logging is enabled for MySQL engine"
# description: "By enabling RDS Cluster audit logging for the MySQL engine with CloudWatch Logs exports, organizations can enhance their security and compliance posture by gaining visibility into database activity and potential security threats."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster
# custom:
#   id: CB_TFAWS_314
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_314

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_rds_cluster"
	supported_engines := ["aurora", "aurora-mysql", "mysql"]
	block.Attributes.engine in supported_engines
} else if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_rds_cluster"
	not has_attribute(block.Attributes, "engine")
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
	"audit" in resource.Attributes.enabled_cloudwatch_logs_exports
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "RDS Cluster audit logging is enabled for MySQL engine.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "RDS Cluster audit logging should be enabled for MySQL engine.",
		"snippet": block,
	}
}
