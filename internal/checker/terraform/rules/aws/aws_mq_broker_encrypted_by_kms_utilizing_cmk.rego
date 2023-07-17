# METADATA
# title: "A customer managed Key (CMK) should be used to encrypt the MQ broker"
# description: "This quick test verifies that the MQ broker encrypts its contents with AWS key management - KMS."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rgeraskin/aws3/latest/docs/resources/mq_broker
# custom:
#   id: CB_TFAWS_233
#   severity: LOW
package lib.terraform.CB_TFAWS_233

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_mq_broker"
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
    resource.Blocks[_].Type == "encryption_options"  
    has_attribute(resource.Blocks[_].Attributes, "kms_key_id")
    resource.Blocks[_].Attributes.kms_key_id != ""
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "Customer Managed Key (CMK) is used to encrypt the MQ broker.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "Customer Managed Key (CMK) must be used to encrypt the MQ broker.",
                "snippet": block }
} 