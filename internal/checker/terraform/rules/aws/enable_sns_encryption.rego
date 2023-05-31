# METADATA
# title: "Enable encryption for SNS topics and uses custom master keys"
# description: "This control checks whether SNS topics are encrypted with a customer-managed CMK."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic
# custom:
#   id: CB_TFAWS_011
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_011

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_sns_topic"
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
    has_attribute(resource.Attributes, "kms_master_key_id")
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "'aws_sns_topic' 'kms_master_key_id' is set properly.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_sns_topic' 'kms_master_key_id' is not set properly.",
                "snippet": block }
} 