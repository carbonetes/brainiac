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

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_imagebuilder_distribution_configuration"
}

has_attribute(key, value) {
  _ = key[value]
}

resource[resource] {
    block := pass[_]
	resource := concat(".", block.Labels)
} 

resource[resource] { 
    block := fail[_]
	resource := concat(".", block.Labels)
} 

pass[resource]{
    resource := input[_]
	isvalid(resource)
    resource.Blocks[_].Type == "distribution"
    resource.Blocks[_].Blocks[_].Type == "ami_distribution_configuration"
    has_attribute(resource.Blocks[_].Blocks[_].Attributes, "kms_key_id")
    resource.Blocks[_].Blocks[_].Attributes.kms_key_id != ""
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "Image Builder Distribution Configuration is utilizing KMS.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "Image Builder Distribution Configuration must utilize KMS.",
                "snippet": block }
} 