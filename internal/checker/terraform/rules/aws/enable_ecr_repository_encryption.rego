# METADATA
# title: "Verify that ECR repositories are encrypted using KMS"
# description: "By utilizing AWS Key Management Service (KMS), ECR repositories can be encrypted, ensuring enhanced security for container image storage and retrieval."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository.html#encryption_configuration
# custom:
#   id: CB_TFAWS_127
#   severity: LOW
package lib.terraform.CB_TFAWS_127

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_ecr_repository"
}

resource[resource] {
    block := pass[_]
	resource := concat(".", block.Labels)
} 

resource[resource] { 
    block := fail[_]
	resource := concat(".", block.Labels)
} 

pass[resource] {
	resource := input[_]
    isvalid(resource)
    resource.Blocks[_].Type == "encryption_configuration"
    resource.Blocks[_].Attributes.encryption_type == "KMS"
}

block_check(block, key) := result {
    block.Type == key
    result := block
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "'aws_ecr_repository' for 'encryption_configuration' is set properly.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_ecr_repository' for 'encryption_configuration' should be set.",
                "snippet": block }
} 