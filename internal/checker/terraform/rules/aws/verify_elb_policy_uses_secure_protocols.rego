# METADATA
# title: "Verify ELB Policy uses only secure protocols"
# description: "By enforcing the use of secure protocols, such as TLS versions 1.2 and above, the policy helps protect sensitive information from potential vulnerabilities and attacks that may be associated with insecure protocols like SSLv3 or older TLS versions."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/load_balancer_policy
# custom:
#   id: CB_TFAWS_197
#   severity: LOW
package lib.terraform.CB_TFAWS_197


isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_load_balancer_policy"
}

resource [resource]{
    block := pass[_]
	resource := concat(".", block.Labels)
} 
resource [resource]{
    block := fail[_]
	resource := concat(".", block.Labels)
} 

fail[resource]{
    resource := input[_]
	isvalid(resource)
    block := resource.Blocks[_]
    block.Type == "policy_attribute"
    protocols := ["Protocol-SSLv3", "Protocol-TLSv1", "Protocol-TLSv1.1"]
    block.Attributes.name == protocols[_]
    not is_false(block.Attributes.value)
}

is_false(value) {
    value == false
}

is_false(value) {
    value == "false"
}

fail[resource]{
    resource := input[_]
	isvalid(resource)
    block := resource.Blocks[_]
    block.Type == "policy_attribute"
    policies := ["ELBSecurityPolicy-2016-08", "ELBSecurityPolicy-TLS-1-1-2017-01", "ELBSecurityPolicy-2015-05", "ELBSecurityPolicy-2015-03", "ELBSecurityPolicy-2015-02"]
    block.Attributes.name == "Reference-Security-Policy"
    block.Attributes.value == policies[_]
}

pass[block] {
    block := input[_]
	isvalid(block)
   	not fail[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "ELB Policy uses only secure protocols",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "ELB Policy must uses only secure protocols",
                "snippet": block }
}
