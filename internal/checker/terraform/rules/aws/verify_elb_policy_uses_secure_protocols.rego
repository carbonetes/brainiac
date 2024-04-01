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
import rego.v1

isvalid(block) if{
	block.Type == "resource"
    some label in block.Labels 
    label == "aws_load_balancer_policy"
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
    some block in resource.Blocks
    block.Type == "policy_attribute"
    protocols := ["Protocol-SSLv3", "Protocol-TLSv1", "Protocol-TLSv1.1"]
    block.Attributes.name in protocols
    not is_false(block.Attributes.value)
}

is_false(false)

is_false("false")

fail contains resource if {
    some resource in input
	isvalid(resource)
    some block in resource.Blocks
    block.Type == "policy_attribute"
    policies := ["ELBSecurityPolicy-2016-08", "ELBSecurityPolicy-TLS-1-1-2017-01", "ELBSecurityPolicy-2015-05", "ELBSecurityPolicy-2015-03", "ELBSecurityPolicy-2015-02"]
    block.Attributes.name == "Reference-Security-Policy"
    block.Attributes.value in policies
}

pass contains block if {
	some block in input
	isvalid(block)
   	not fail[block]
}

passed contains result if {
    some block in pass
	result := { "message": "ELB Policy uses only secure protocols",
                "snippet": block}
}

failed contains result if {
    some block in fail
	result := { "message": "ELB Policy must uses only secure protocols",
                "snippet": block }
}
