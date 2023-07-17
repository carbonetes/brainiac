# METADATA
# title: "Verify that Kinesis Firehose delivery stream is encrypted"
# description: "By enabling server-side encryption for the Kinesis Firehose delivery stream, sensitive data is protected during transit and at rest, ensuring the confidentiality and integrity of the data, and meeting compliance and security requirements."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kinesis_firehose_delivery_stream#server_side_encryption
# custom:
#   id: CB_TFAWS_229
#   severity: LOW
package lib.terraform.CB_TFAWS_229

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_kinesis_firehose_delivery_stream"
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
    resource.Blocks[_].Type == "server_side_encryption"
    resource.Blocks[_].Attributes.enabled == true
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "Kinesis Firehose delivery stream is encrypted",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "Kinesis Firehose delivery stream should be encrypted",
                "snippet": block }
} 