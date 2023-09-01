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

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_rds_cluster"
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
    count(resource.Attributes.enabled_cloudwatch_logs_exports) > 0
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "RDS Cluster log capture is enabled.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "RDS Cluster log capture should be enabled.",
                "snippet": block }
} 