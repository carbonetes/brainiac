# METADATA
# title: "Verify EBS Volume is encrypted by KMS using a customer managed Key (CMK)"
# description: "By encrypting the EBS volume with a customer managed CMK, you have control over the encryption keys and can enforce stronger security measures. "
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dms_replication_instance
# custom:
#   id: CB_TFAWS_196
#   severity: LOW
package lib.terraform.CB_TFAWS_196
import rego.v1

isvalid(block) if{
	block.Type == "resource"
    some label in block.Labels 
    label == "aws_dms_replication_instance"
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
    has_attribute(resource.Attributes, "kms_key_id")
    resource.Attributes.kms_key_id != ""
}

fail contains block if {
	some block in input
	isvalid(block)
   	not pass[block]
}

passed contains result if {
    some block in pass
	result := { "message": "EBS Volume is encrypted by KMS using a customer managed Key (CMK)",
                "snippet": block }
}

failed contains result if {
    some block in fail
	result := { "message": "EBS Volume is must be ecrypted by KMS using a customer managed Key (CMK)",
                "snippet": block }
} 