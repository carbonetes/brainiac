# METADATA
# title: "Verify ECR Image Tags are immutable"
# description: "Immutable tags can help prevent unauthorized or malicious changes to your container images, as well as reduce the risk of accidental or unintended changes."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository
# custom:
#   id: CB_TFAWS_049
#   severity: LOW
package lib.terraform.CB_TFAWS_049

import future.keywords.in 


isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_ecr_repository"
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
    resource.Attributes.image_tag_mutability == "IMMUTABLE"
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "'aws_ecr_repository' 'image_tag_mutability' is set properly.",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_kms_key' 'image_tag_mutability' should be set to 'IMMUTABLE'",
                "snippet": block }
}