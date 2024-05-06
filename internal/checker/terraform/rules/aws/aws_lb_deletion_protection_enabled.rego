# METADATA
# title: "Verify that deletion protection is activated in the load balancer"
# description: "This policy recognizes Elastic Load Balancers version 2 (ELBv2) that have the deletion protection option turned off. By enabling delete protection for these ELBs, irrevocable data loss brought on by mistaken or malicious actions is avoided."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/3.61.0/docs/data-sources/lb
# custom:
#   id: CB_TFAWS_129
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_129
import rego.v1

isvalid(block) if{
	block.Type == "resource"
    some label in block.Labels
    supported_resource := ["aws_alb", "aws_lb"]
    label in supported_resource
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

pass contains resource if{
    resource := input[_]
	isvalid(resource)
    has_attribute(resource.Attributes, "enable_deletion_protection")
    resource.Attributes.enable_deletion_protection == true
}

fail contains block if {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed contains result if {
    some block in pass
	result := { "message": "'aws_alb', 'aws_lb' deletion protection is active.",
                "snippet": block}
}

failed contains result if {
    some block in fail
	result := { "message": "'aws_alb', 'aws_lb' deletion protection should be active.",
                "snippet": block }
}
