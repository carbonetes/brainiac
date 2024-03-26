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
import rego.v1

isvalid(block) if{
	block.Type == "resource"
    some label in block.Labels 
    label == "aws_ecr_repository"
}

resource contains resource if {
    some block in pass
	resource := concat(".", block.Labels)
} 

resource contains resource if{
	some block in fail
	resource := concat(".", block.Labels)
} 

pass contains resource if{
    some resource in input
    isvalid(resource)
    resource.Blocks[_].Type == "encryption_configuration"
    resource.Blocks[_].Attributes.encryption_type == "KMS"
}

fail contains block if {
    some block in input
	isvalid(block)
   	not pass[block]
}

passed contains result if {
    some block in pass
	result := { "message": "'aws_ecr_repository' for 'encryption_configuration' is set properly.",
                "snippet": block }
}

failed contains result if {
    some block in fail
	result := { "message": "'aws_ecr_repository' for 'encryption_configuration' should be set.",
                "snippet": block }
} 