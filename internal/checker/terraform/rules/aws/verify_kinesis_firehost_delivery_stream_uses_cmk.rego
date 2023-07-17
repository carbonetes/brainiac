# METADATA
# title: "Verify that Kinesis Firehose Delivery Streams are encrypted with CMK"
# description: "By encrypting Kinesis Firehose Delivery Streams with a Customer Managed CMK, data integrity and confidentiality are ensured, providing an essential layer of security for sensitive information during transit and storage."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kinesis_firehose_delivery_stream#server_side_encryption
# custom:
#   id: CB_TFAWS_232
#   severity: LOW
package lib.terraform.CB_TFAWS_232

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
    resource.Blocks[_].Attributes.key_arn != ""
    resource.Blocks[_].Attributes.key_type == "CUSTOMER_MANAGED_CMK"
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "Kinesis Firehose Delivery Streams are encrypted with CMK",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "Kinesis Firehose Delivery Streams should be encrypted with CMK",
                "snippet": block }
} 