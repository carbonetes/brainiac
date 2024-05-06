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
import rego.v1

isvalid(block) if{
	block.Type == "resource"
    some label in block.Labels 
    label == "aws_kinesis_firehose_delivery_stream"
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
    some block in resource.Blocks
    block.Type == "server_side_encryption"
    block.Attributes.enabled == true
    block.Attributes.key_arn != ""
    block.Attributes.key_type == "CUSTOMER_MANAGED_CMK"
}

fail contains block if {
	some block in input
	isvalid(block)
   	not pass[block]
}

passed contains result if {
    some block in pass
	result := { "message": "Kinesis Firehose Delivery Streams are encrypted with CMK",
                "snippet": block }
}

failed contains result if {
    some block in fail
	result := { "message": "Kinesis Firehose Delivery Streams should be encrypted with CMK",
                "snippet": block }
} 