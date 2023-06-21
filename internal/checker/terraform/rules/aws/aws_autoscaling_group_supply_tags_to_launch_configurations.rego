# METADATA
# title: "Tags for launch configurations should be provided by autoscaling groups"
# description: "Tags assist you in recognizing and managing your AWS resources as well as regulating access to Auto Scaling groups based on tags."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group
# custom:
#   id: CB_TFAWS_146
#   severity: LOW
package lib.terraform.CB_TFAWS_146

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_autoscaling_group"
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
    has_attribute(resource.Attributes, "tags")
}


fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "Tags for launch configurations is provided by autoscaling groups.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "Tags for launch configurations must be provided by autoscaling groups.",
                "snippet": block }
} 