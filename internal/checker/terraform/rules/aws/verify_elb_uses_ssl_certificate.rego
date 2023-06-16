# METADATA
# title: "Verify that Elastic Load Balancer(s) uses SSL certificates provided by AWS Certificate Manager"
# description: "By using SSL certificates from AWS Certificate Manager, you can leverage the managed certificate service, which simplifies certificate management and provides automated renewal. "
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/3.63.0/docs/resources/elb#listener
# custom:
#   id: CB_TFAWS_125
#   severity: HIGH
package lib.terraform.CB_TFAWS_125

import future.keywords.in 


isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_elb"
}

resource [resource]{
    block := pass[_]
	resource := concat(".", block.Labels)
} 
resource [resource]{
    block := fail[_]
	resource := concat(".", block.Labels)
} 

has_attribute(key, value) {
  _ = key[value]
}

pass[resource] {
    resource := input[_]
    isvalid(resource)
    block := resource.Blocks[_]
    block.Type == "listener"
    has_attribute(block.Attributes, "ssl_certificate_id")
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "Elastic Load Balancer(s) uses SSL certificates",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "Elastic Load Balancer(s) should be using SSL certificates",
                "snippet": block}
}
