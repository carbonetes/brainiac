# METADATA
# title: "A Customer Managed Key (CMK) should be used by KMS to encrypt Kinesis Video Stream"
# description: "This quick test verifies that Kinesis Video Stream encrypts its content using AWS key management - KMS."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kinesis_video_stream
# custom:
#   id: CB_TFAWS_168
#   severity: HIGH
package lib.terraform.CB_TFAWS_168

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_kinesis_video_stream"
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
	result := { "message": "Customer Managed Key (CMK) is used by KMS to encrypt Kinesis Video Stream.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "Customer Managed Key (CMK) must be used by KMS to encrypt Kinesis Video Stream.",
                "snippet": block }
} 