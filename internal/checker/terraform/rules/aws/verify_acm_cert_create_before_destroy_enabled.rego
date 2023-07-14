# METADATA
# title: "Verify Create before destroy for ACM certificates is enabled"
# description: "By utilizing the `create_before_destroy` lifecycle configuration in Terraform for ACM certificates, you ensure a seamless transition by creating the new certificate before removing the old one, maintaining uninterrupted secure communication for your domain."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate
# custom:
#   id: CB_TFAWS_221
#   severity: LOW
package lib.terraform.CB_TFAWS_221

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_acm_certificate"
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
    blocks := resource.Blocks[_]
    blocks.Type == "lifecycle"
    blocks.Attributes.create_before_destroy == true
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "Create before destroy for ACM certificates is enabled",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "Create before destroy for ACM certificates should be enabled",
                "snippet": block }
}
