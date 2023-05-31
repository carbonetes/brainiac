# METADATA
# title: "Enable encryption for SQS queue and uses custom master keys"
# description: "This control checks whether Amazon Simple Queue Service (SQS) queues are encrypted with AWS Key Management Service (AWS KMS) customer master keys (CMKs)."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue
# custom:
#   id: CB_TFAWS_014
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_014

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_sqs_queue"
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
	result := { "message": "'aws_sqs_queue' 'kms_master_key_id' is set properly.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_sqs_queue' 'kms_master_key_id' is not set properly.",
                "snippet": block }
} 