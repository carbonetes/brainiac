# METADATA
# title: "Verify that KMS key is enabled"
# description: "By enabling the KMS key with the `is_enabled` property, sensitive data can be securely encrypted and decrypted, providing an essential layer of protection against unauthorized access and ensuring the confidentiality and integrity of critical information."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key#is_enabled
# custom:
#   id: CB_TFAWS_199
#   severity: LOW
package lib.terraform.CB_TFAWS_199
import rego.v1

isvalid(block) if{
	block.Type == "resource"
    some label in block.Labels 
    label == "aws_kms_key"
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
    not has_attribute(resource.Attributes, "is_enabled")
}

pass contains resource if {
    some resource in input
    isvalid(resource)
    resource.Attributes.is_enabled == true
}

fail contains block if {
	some block in input
	isvalid(block)
   	not pass[block]
}

passed contains result if {
    some block in pass
	result := { "message": "'aws_kms_key' for 'is_enabled' is set properly.",
                "snippet": block}
}

failed contains result if {
    some block in fail
	result := { "message": "'aws_kms_key' for 'is_enabled' should be set.",
                "snippet": block}
}


