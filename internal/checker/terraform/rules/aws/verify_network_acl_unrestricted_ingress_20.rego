# METADATA
# title: "Verify that AWS NACL does not allow ingress from 0.0.0.0/0 to port 20"
# description: "By creating a network ACL rule that denies ingress from `0.0.0.0/0` to port 20, we enhance the security of our AWS infrastructure by restricting access to a critical port from any IP address."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_rule
# custom:
#   id: CB_TFAWS_218
#   severity: LOW
package lib.terraform.CB_TFAWS_218

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_network_acl_rule"
}

has_attribute(key, value) {
  _ = key[value]
}

resource [resource]{
    block := pass[_]
	resource := concat(".", block.Labels)
} 
resource [resource]{
    block := fail[_]
	resource := concat(".", block.Labels)
} 

pass[resource]{
    resource := input[_]
	isvalid(resource)
    not has_attribute(resource.Attributes, "rule_action")
}

pass[block] {
    block := input[_]
	isvalid(block)
   	not fail[block]
}

fail[resource] {
    resource := input[_]
	isvalid(resource)
    resource.Attributes.rule_action == "allow"
    resource.Attributes.cidr_block == "0.0.0.0/0"
    to_number(resource.Attributes.from_port) == 20
}

fail[resource] {
    resource := input[_]
	isvalid(resource)
    resource.Attributes.rule_action == "allow"
    resource.Attributes.cidr_block == "0.0.0.0/0"
    to_number(resource.Attributes.to_port) == 20
}

passed[result] {
	block := pass[_]
	result := { "message": "AWS NACL is configured to deny ingress from 0.0.0.0/0 to port 21",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "AWS NACL should not allow ingress from 0.0.0.0/0 to port 21.",
                "snippet": block }
}
