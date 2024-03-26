# METADATA
# title: "Verify VPC subnets do not assign public IP by default"
# description: "By ensuring that subnets do not automatically assign public IP addresses to instances, you can prevent accidental exposure of resources to the public internet and reduce the attack surface."
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/2.43.0/docs/resources/subnet
# custom:
#   id: CB_TFAWS_128
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_128
import rego.v1

isvalid(block) if{
	block.Type == "resource"
    some label in block.Labels 
    label == "aws_subnet"
}

resource contains resource if {
    some block in pass
	resource := concat(".", block.Labels)
} 

resource contains resource if{
	some block in fail
	resource := concat(".", block.Labels)
} 

fail contains resource if{
    some resource in input
    isvalid(resource)
    resource.Attributes.map_public_ip_on_launch == true

}

pass contains block if {
    some block in input
	isvalid(block)
   	not fail[block]
}

passed contains result if {
    some block in pass
	result := { "message": "VPC subnets is not assign public IP by default",
                "snippet": block}
}

failed contains result if {
    some block in fail
	result := { "message": "VPC subnets should not assign public IP by default",
                "snippet": block}
}
