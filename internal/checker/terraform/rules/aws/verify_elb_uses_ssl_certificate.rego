# METADATA
# title: "Verify that Elastic Load Balancer(s) uses SSL certificates provided by AWS Certificate Manager"
# description: "By using SSL certificates from AWS Certificate Manager, you can leverage the managed certificate service, which simplifies certificate management and provides automated renewal. "
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/3.63.0/docs/resources/elb#listener
# custom:
#   id: CB_TFAWS_125
#   severity: HIGH
package lib.terraform.CB_TFAWS_125
import rego.v1

isvalid(block) if{
	block.Type == "resource"
    some label in block.Labels 
    label == "aws_elb"
}

resource contains resource if {
    some block in pass
	resource := concat(".", block.Labels)
} 

resource contains resource if{
	some block in fail
	resource := concat(".", block.Labels)
} 

has_attribute(key, value) if {
    value in object.keys(key)
}

pass contains resource if{
    some resource in input
    isvalid(resource)
    block := resource.Blocks[_]
    block.Type == "listener"
    has_attribute(block.Attributes, "ssl_certificate_id")
}

fail contains block if {
    some block in input
	isvalid(block)
   	not pass[block]
}

passed contains result if {
    some block in pass
	result := { "message": "Elastic Load Balancer(s) uses SSL certificates",
                "snippet": block}
}

failed contains result if {
    some block in fail
	result := { "message": "Elastic Load Balancer(s) should be using SSL certificates",
                "snippet": block}
}
