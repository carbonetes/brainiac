# METADATA
# title: "Verify no security groups allow ingress from 0.0.0.0:0 to port 22"
# description: "This security check is aimed at verifying that no security groups in a network allow incoming traffic from the IP address range 0.0.0.0:0 to the port 22, which is the default port for SSH traffic."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group
# custom:
#   id: CB_TFAWS_044
#   severity: LOW
package lib.terraform.CB_TFAWS_044

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	supportedresource := [
        "aws_security_group", 
        "aws_security_group_rule", 
        "aws_vpc_security_group_ingress_rule"]
	label in supportedresource
}

resource contains resource if {
	some block in pass
	resource := concat(".", block.Labels)
}

resource contains resource if {
	some block in fail
	resource := concat(".", block.Labels)
}

fail contains resource if {
    some resource in input
	isvalid(resource)
    some childblock in resource.Blocks
    childblock.Type == "ingress"
    childblock.Attributes.to_port == "22"
    some cidr in childblock.Attributes.cidr_blocks
	cidr == "0.0.0.0/0"
}

fail contains resource if {
    some resource in input
	isvalid(resource)
    resource.Attributes.type == "ingress"
    resource.Attributes.to_port == "22"
  	some cidr in resource.Attributes.cidr_blocks
	cidr == "0.0.0.0/0"
}

fail contains resource if {
    some resource in input
	isvalid(resource)
    resource.Attributes.to_port == "22"
    some cidr in resource.Attributes.cidr_blocks
	cidr == "0.0.0.0/0"
}

pass contains block if {
	some block in input
	isvalid(block)
	not fail[block]
}

passed contains result if {
	some block in pass
	result := { "message": "No security groups rule allow ingress from 0.0.0.0:0 to port 22",
                "snippet": block }
}

failed contains result if {
	some block in fail
	result := { "message": "security groups rule should not allow ingress from 0.0.0.0:0 to port 22.",
                "snippet": block }
} 