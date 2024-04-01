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
    resource.Blocks[_].Type == "server_side_encryption"
    resource.Blocks[_].Attributes.enabled == true
}

fail contains block if {
	some block in input
	isvalid(block)
   	not pass[block]
}

passed contains result if {
    some block in pass
	result := { "message": "Kinesis Firehose delivery stream is encrypted",
                "snippet": block }
}

failed contains result if {
    some block in fail
	result := { "message": "Kinesis Firehose delivery stream should be encrypted",
                "snippet": block }
} 