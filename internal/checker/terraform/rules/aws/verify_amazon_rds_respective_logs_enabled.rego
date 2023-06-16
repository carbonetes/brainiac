# METADATA
# title: "Verify that respective logs of Amazon Relational Database Service (Amazon RDS) are enabled"
# description: "By enabling these logs, you gain visibility into the activities and events happening within your Amazon RDS instances, which can help with troubleshooting, performance optimization, compliance, and security monitoring."
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/3.63.0/docs/resources/elb#listener
# custom:
#   id: CB_TFAWS_126
#   severity: LOW
package lib.terraform.CB_TFAWS_126

import future.keywords.in 


isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_db_instance"
}

resource [resource]{
    block := pass[_]
	resource := concat(".", block.Labels)
} 
resource [resource]{
    block := fail[_]
	resource := concat(".", block.Labels)
} 

has_attribute(key, value) {
  _ = key[value]
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
	result := { "message": "Respective logs of (Amazon RDS) are enabled",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_db_instance' enabled_cloudwatch_logs_exports should be set",
                "snippet": block}
}
