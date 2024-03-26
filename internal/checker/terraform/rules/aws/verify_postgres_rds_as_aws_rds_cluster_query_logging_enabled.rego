# METADATA
# title: "Verify Postgres RDS as aws_rds_cluster has Query Logging enabled"
# description: "This helps enhance monitoring and auditing capabilities by capturing SQL queries executed on the database."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/rds_cluster.html
# custom:
#   id: CB_TFAWS_322
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_322

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	valid_resources := ["aws_rds_cluster", "aws_rds_cluster_parameter_group"]
	some label in block.Labels
	label in valid_resources
}

resource contains resource if {
	some block in pass
	resource := concat(".", block.Labels)
}

resource contains resource if {
	some block in fail
	resource := concat(".", block.Labels)
}

is_aws_rds_paramexist if {
	some resource in input
	resource.Type == "resource"
	"aws_rds_cluster_parameter_group" in resource.Labels
}

pass contains resource if {
	some resource in input
	isvalid(resource)
	is_aws_rds_paramexist
	valid_engine
}

pass contains resource if {
	some resource in input
	isvalid(resource)
	has_log_statement
	has_log_duration_statement
}

valid_engine if {
	some resource in input
	resource.Type == "resource"
	"aws_rds_cluster" in resource.Labels
	resource.Attributes.engine == "aurora-postgresql"
}

has_log_statement if {
	some resource in input
	resource.Type == "resource"
	some label in resource.Labels
	label == "aws_rds_cluster_parameter_group"
	some block in resource.Blocks
	block.Type == "parameter"
	block.Attributes.name == "log_statement"
}

has_log_duration_statement if {
	some resource in input
	resource.Type == "resource"
	some label in resource.Labels
	label == "aws_rds_cluster_parameter_group"
	some block in resource.Blocks
	block.Type == "parameter"
	block.Attributes.name == "log_min_duration_statement"
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "Postgres RDS as aws_rds_cluster has Query Logging enabled.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Postgres RDS as aws_rds_cluster should have Query Logging enabled.",
		"snippet": block,
	}
}
