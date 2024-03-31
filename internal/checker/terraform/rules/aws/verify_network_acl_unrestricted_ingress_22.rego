# METADATA
# title: "Verify that AWS NACL does not allow ingress from 0.0.0.0/0 to port 22"
# description: "By creating a network ACL rule that denies ingress from `0.0.0.0/0` to port 22, we enhance the security of our AWS infrastructure by restricting access to a critical port from any IP address."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_rule
# custom:
#   id: CB_TFAWS_220
#   severity: LOW
package lib.terraform.CB_TFAWS_220
import rego.v1

isvalid(block) if{
	block.Type == "resource"
    some label in block.Labels 
    label == "aws_network_acl_rule"
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

fail contains resource if {
    some resource in input
	isvalid(resource)
    resource.Attributes.rule_action == "allow"
    resource.Attributes.cidr_block == "0.0.0.0/0"
    to_number(resource.Attributes.from_port) == 22
}

fail contains resource if {
    some resource in input
	isvalid(resource)
    resource.Attributes.rule_action == "allow"
    resource.Attributes.cidr_block == "0.0.0.0/0"
    to_number(resource.Attributes.to_port) == 22
}

pass contains block if {
    some block in input
	isvalid(block)
    not has_attribute(block.Attributes, "rule_action")
    not fail[block]
}

passed contains result if {
    some block in pass
	result := { "message": "AWS NACL is configured to deny ingress from 0.0.0.0/0 to port 22",
                "snippet": block}
}

failed contains result if {
    some block in fail
	result := { "message": "AWS NACL should not allow ingress from 0.0.0.0/0 to port 22.",
                "snippet": block }
}
