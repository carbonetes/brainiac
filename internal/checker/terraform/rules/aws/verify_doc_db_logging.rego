# METADATA
# title: "Verify that DocDB Logging is enabled"
# description: "By enabling DocDB Logging in Amazon DocumentDB clusters using the provided Terraform configuration, you can ensure comprehensive monitoring and auditing of database activities."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/docdb_cluster#enabled_cloudwatch_logs_exports
# custom:
#   id: CB_TFAWS_090
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_090

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_docdb_cluster"
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
	log_types := ["profiler", "audit"]
	some resource in input
	isvalid(resource)
	attribute := resource.Attributes
	has_attribute(attribute, "enabled_cloudwatch_logs_exports")
	some cloud in attribute.enabled_cloudwatch_logs_exports
	cloud in log_types
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "'aws_docdb_cluster' for 'enabled_cloudwatch_logs_exports' is set properly.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "'aws_docdb_cluster' for 'enabled_cloudwatch_logs_exports' should be set.",
		"snippet": block,
	}
}