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

import future.keywords.if

supported_engines := ["aurora","aurora-mysql","mysql"]

isvalid(block) := true if {
	block.Type == "resource"
    block.Labels[_] == "aws_rds_cluster"
	block.Attributes.engine == supported_engines[_]
} else := true if {
	block.Type == "resource"
    block.Labels[_] == "aws_rds_cluster"
	not has_attribute(block.Attributes, "engine")
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
	resource.Attributes.enabled_cloudwatch_logs_exports[_] == "audit"
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "RDS Cluster audit logging is enabled for MySQL engine.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "RDS Cluster audit logging should be enabled for MySQL engine.",
                "snippet": block }
} 