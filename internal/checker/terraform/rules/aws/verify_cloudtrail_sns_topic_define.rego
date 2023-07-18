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

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_cloudtrail"
}

resource[resource] {
    block := pass[_]
	resource := concat(".", block.Labels)
} 

resource[resource] { 
    block := fail[_]
	resource := concat(".", block.Labels)
} 

pass[resource]{
    resource := input[_]
	isvalid(resource)
    resource.Attributes.sns_topic_name != ""
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "'aws_cloudtrail' 'sns_topic_name' is set properly.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_cloudtrail' 'sns_topic_name' must be defined.",
                "snippet": block }
} 