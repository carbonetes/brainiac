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

log_types := ["profiler", "audit"]

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_docdb_cluster"
}

has_attribute(key, value) {
  _ = key[value]
}

resource[resource] {
    block := pass[_]
	resource := concat(".", block.Labels)
} 

resource[resource] { 
    block := fail[_]
	resource := concat(".", block.Labels)
} 

pass[resource] {
	resource := input[_]
    isvalid(resource)
    has_attribute(resource.Attributes, "enabled_cloudwatch_logs_exports")
    resource.Attributes.enabled_cloudwatch_logs_exports[_] == log_types[_]
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "'aws_docdb_cluster' for 'enabled_cloudwatch_logs_exports' is set properly.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_docdb_cluster' for 'enabled_cloudwatch_logs_exports' should be set.",
                "snippet": block }
} 