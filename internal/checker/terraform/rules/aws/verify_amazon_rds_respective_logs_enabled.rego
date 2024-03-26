# METADATA
# title: "Verify that respective logs of Amazon Relational Database Service (Amazon RDS) are enabled"
# description: "By enabling these logs, you gain visibility into the activities and events happening within your Amazon RDS instances, which can help with troubleshooting, performance optimization, compliance, and security monitoring."
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/3.63.0/docs/resources/elb#listener
# custom:
#   id: CB_TFAWS_126
#   severity: LOW
package lib.terraform.CB_TFAWS_126
import rego.v1

isvalid(block) if{
	block.Type == "resource"
    some label in block.Labels 
    label == "aws_db_instance"
}

resource contains resource if {
    some block in pass
	resource := concat(".", block.Labels)
} 

resource contains resource if{
	some block in fail
	resource := concat(".", block.Labels)
} 

has_attribute(key, value) if {
    value in object.keys(key)
}

pass contains resource if{
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
	result := { "message": "Respective logs of (Amazon RDS) are enabled",
                "snippet": block}
}

failed contains result if {
    some block in fail
	result := { "message": "'aws_db_instance' enabled_cloudwatch_logs_exports should be set",
                "snippet": block}
}
