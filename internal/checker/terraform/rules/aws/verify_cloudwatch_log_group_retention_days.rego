# METADATA
# title: "Verify that CloudWatch Log Group specifies retention days"
# description: "By setting retention days for a log group, you can control how long log events are retained before they expire and are automatically deleted."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group
# custom:
#   id: CB_TFAWS_066
#   severity: LOW
package lib.terraform.CB_TFAWS_066


isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_cloudwatch_log_group"
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
    has_attribute(resource.Attributes, "retention_in_days")
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "'aws_cloudwatch_log_group' 'retention_in_days' is set properly.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_cloudwatch_log_group' 'retention_in_days' should be set.",
                "snippet": block }
} 