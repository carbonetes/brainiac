# METADATA
# title: "Verify that VPC Endpoint Service is configured for Manual Acceptance"
# description: "When the VPC Endpoint Service is set to manual acceptance, any VPC owner wanting to access the service's endpoints must explicitly request access and wait for approval from the service owner."
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/2.50.0/docs/data-sources/vpc_endpoint_service
# custom:
#   id: CB_TFAWS_119
#   severity: LOW
package lib.terraform.CB_TFAWS_119

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_vpc_endpoint_service"
}

resource [resource]{
    block := pass[_]
	resource := concat(".", block.Labels)
} 
resource [resource]{
    block := fail[_]
	resource := concat(".", block.Labels)
} 

pass[resource] {
    resource := input[_]
    isvalid(resource)
    resource.Attributes.acceptance_required == true
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "VPC Endpoint Service is configured for Manual Acceptance.",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "VPC Endpoint Service should be configured for Manual Acceptance.",
                "snippet": block}
}
