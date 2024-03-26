# METADATA
# title: "Ensure that tags for launch configurations should be provided by autoscaling groups"
# description: "Tags assist you in recognizing and managing your AWS resources as well as regulating access to Auto Scaling groups based on tags."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group
# custom:
#   id: CB_TFAWS_146
#   severity: LOW
package lib.terraform.CB_TFAWS_146
import rego.v1

isvalid(block) if{
	block.Type == "resource"
    some label in block.Labels 
    label == "aws_autoscaling_group"
}

has_attribute(key, value) if {
    value in object.keys(key)
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
    has_attribute(resource.Attributes, "tag")
}

pass contains resource if {
    some resource in input
	isvalid(resource)
    has_attribute(resource.Attributes, "tags")
}


fail contains block if {
	some block in input
	isvalid(block)
   	not pass[block]
}

passed contains result if {
    some block in pass
	result := { "message": "Tags for launch configurations is provided by autoscaling groups.",
                "snippet": block }
}

failed contains result if {
    some block in fail
	result := { "message": "Tags for launch configurations must be provided by autoscaling groups.",
                "snippet": block }
} 