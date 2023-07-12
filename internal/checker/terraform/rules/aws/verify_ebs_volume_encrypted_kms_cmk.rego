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

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_dms_replication_instance"
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
    has_attribute(resource.Attributes, "kms_key_id")
    resource.Attributes.kms_key_id != ""
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "EBS Volume is encrypted by KMS using a customer managed Key (CMK)",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "EBS Volume is must be ecrypted by KMS using a customer managed Key (CMK)",
                "snippet": block }
} 