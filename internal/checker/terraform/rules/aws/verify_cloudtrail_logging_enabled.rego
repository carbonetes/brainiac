# METADATA
# title: "Verify CloudTrail logging is enabled"
# description: "By enabling CloudTrail logging, you gain visibility into actions taken on your resources, including who performed the action, when it occurred, and what resources were affected."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudtrail#enable_logging
# custom:
#   id: CB_TFAWS_230
#   severity: LOW
package lib.terraform.CB_TFAWS_230

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_cloudtrail"
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

pass[resource]{
    resource := input[_]
	isvalid(resource)
    resource.Attributes.enable_logging == true
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "'aws_cloudtrail' 'enable_logging' is set properly.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_cloudtrail' 'enable_logging' should be set to true.",
                "snippet": block }
} 