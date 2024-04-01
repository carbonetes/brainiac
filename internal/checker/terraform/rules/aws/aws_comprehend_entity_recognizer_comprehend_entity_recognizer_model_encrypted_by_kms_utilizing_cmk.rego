# METADATA
# title: "A customer managed Key (CMK) should be used to encrypt the Comprehend Entity Recognizer's model"
# description: "This quick test verifies that the Comprehend Entity Recognizer's model encrypts its contents with AWS key management - KMS."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/comprehend_entity_recognizer
# custom:
#   id: CB_TFAWS_242
#   severity: HIGH
package lib.terraform.CB_TFAWS_242
import rego.v1

isvalid(block) if{
	block.Type == "resource"
    some label in block.Labels 
    label == "aws_comprehend_entity_recognizer"
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
    has_attribute(resource.Attributes, "model_kms_key_id")
    resource.Attributes.model_kms_key_id != ""
}

fail contains block if {
	some block in input
	isvalid(block)
   	not pass[block]
}

passed contains result if {
    some block in pass
	result := { "message": "Customer Managed Key (CMK) is used to encrypt the Comprehend Entity Recognizer's model.",
                "snippet": block }
}

failed contains result if {
    some block in fail
	result := { "message": "Customer Managed Key (CMK) must be used to encrypt the Comprehend Entity Recognizer's model.",
                "snippet": block }
} 