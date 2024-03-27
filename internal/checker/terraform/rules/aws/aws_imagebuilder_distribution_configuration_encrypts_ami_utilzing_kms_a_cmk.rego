# METADATA
# title: "Verify that the Image Builder Distribution Configuration uses KMS, a customer managed Key (CMK), to encrypt AMIs"
# description: "This policy recognizes Elastic File Systems (EFSs) that use default KMS keys rather than customer-managed keys to encrypt data. Using customer-managed KMS Keys to encrypt your EFS data is recommended. You have total control over the encrypted data through it."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/imagebuilder_distribution_configuration
# custom:
#   id: CB_TFAWS_190
#   severity: LOW
package lib.terraform.CB_TFAWS_190
import rego.v1

isvalid(block) if{
	block.Type == "resource"
    some label in block.Labels 
    label == "aws_imagebuilder_distribution_configuration"
}

has_attribute(key, value) if {
    value in object.keys(key)
}

resource contains resource if {
    some block in pass
	resource := concat(".", block.Labels)
} 

resource contains resource if{
	some block in fail
	resource := concat(".", block.Labels)
}  

pass contains resource if {
    some resource in input
	isvalid(resource)
    some block_one in resource.Blocks
    block_one.Type == "distribution"
    some block_two in block_one.Blocks
    block_two.Type == "ami_distribution_configuration"
    has_attribute(block_two.Attributes, "kms_key_id")
    block_two.Attributes.kms_key_id != ""
}

fail contains block if {
	some block in input
	isvalid(block)
   	not pass[block]
}

passed contains result if {
    some block in pass
	result := { "message": "Image Builder Distribution Configuration is utilizing KMS.",
                "snippet": block }
}

failed contains result if {
    some block in fail
	result := { "message": "Image Builder Distribution Configuration must utilize KMS.",
                "snippet": block }
} 