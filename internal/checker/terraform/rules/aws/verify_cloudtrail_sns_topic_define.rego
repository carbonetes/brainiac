# METADATA
# title: "Verify CloudTrail defines an SNS Topic"
# description: "By configuring an SNS Topic for CloudTrail, you can receive notifications whenever significant actions are taken, such as API calls, resource modifications, or security-related events."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudtrail#sns_topic_name
# custom:
#   id: CB_TFAWS_231
#   severity: LOW
package lib.terraform.CB_TFAWS_231
import rego.v1

isvalid(block) if{
	block.Type == "resource"
    some label in block.Labels 
    label == "aws_cloudtrail"
}

resource contains resource if {
    some block in pass
	resource := concat(".", block.Labels)
} 

resource contains resource if{
	some block in fail
	resource := concat(".", block.Labels)
} 

pass contains resource if {
    some resource in input
	isvalid(resource)
    resource.Attributes.sns_topic_name != ""
}

fail contains block if {
	some block in input
	isvalid(block)
   	not pass[block]
}

passed contains result if {
    some block in pass
	result := { "message": "'aws_cloudtrail' 'sns_topic_name' is set properly.",
                "snippet": block }
}

failed contains result if {
    some block in fail
	result := { "message": "'aws_cloudtrail' 'sns_topic_name' must be defined.",
                "snippet": block }
} 