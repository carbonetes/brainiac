# METADATA
# title: "Verify that no default VPC is going to be provisioned"
# description: "The constraints of default VPCs may make them incompatible for all use cases."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_vpc.html
# custom:
#   id: CB_TFAWS_133
#   severity: LOW
package lib.terraform.CB_TFAWS_133
import rego.v1

isvalid(block) if{
	block.Type == "resource"
    some label in block.Labels 
    label == "aws_default_vpc"
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
	tags := resource.Attributes.tags
    tags.Name == "Default VPC"
}

fail contains block if {
	some block in input
	isvalid(block)
   	not pass[block]
}

passed contains result if {
    some block in pass
	result := { "message": "'aws_default_vpc' not provisioned.",
                "snippet": block }
}

failed contains result if {
    some block in fail
	result := { "message": "'aws_default_vpc' should not be provisioned.",
                "snippet": block }
}
