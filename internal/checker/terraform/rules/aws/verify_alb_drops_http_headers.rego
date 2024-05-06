# METADATA
# title: "Verify that ALB drops HTTP headers"
# description: "Dropping HTTP headers helps in scenarios where you want to remove sensitive or unnecessary information that might be present in incoming requests."
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/3.4.0/docs/data-sources/lb
# custom:
#   id: CB_TFAWS_130
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_130
import rego.v1

isvalid(block) if{
	block.Type == "resource"
    some label in block.Labels
    supported_resource := ["aws_alb", "aws_lb"]
    label in supported_resource
}

resource contains resource if {
    some block in pass
	resource := concat(".", block.Labels)
} 

resource contains resource if{
	some block in fail
	resource := concat(".", block.Labels)
} 

pass contains resource if{
    some resource in input
    isvalid(resource)
    resource.Attributes.drop_invalid_header_fields == true
}

fail contains block if {
    some block in input
	isvalid(block)
   	not pass[block]
}

passed contains result if {
    some block in pass
	result := { "message": "ALB drops HTTP headers",
                "snippet": block}
}

failed contains result if {
    some block in fail
	result := { "message": "ALB 'drop_invalid_header_fields' should be set to true",
                "snippet": block}
}
