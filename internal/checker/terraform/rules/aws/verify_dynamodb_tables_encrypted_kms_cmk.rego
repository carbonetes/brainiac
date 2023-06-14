# METADATA
# title: "Verify DynamoDB Tables are encrypted using a KMS Customer Managed CMK"
# description: "By utilizing a customer-managed CMK for encryption, you can ensure that the encryption keys used to protect your DynamoDB data are managed and controlled by you."
# scope: package
# related_resources:
# - https://registry.terraform.io/modules/terraform-aws-modules/dynamodb-table/aws/latest
# custom:
#   id: CB_TFAWS_111
#   severity: LOW
package lib.terraform.CB_TFAWS_111

import future.keywords.in 

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_dynamodb_table"
}

resource [resource]{
    block := pass[_]
	resource := concat(".", block.Labels)
} 
resource [resource]{
    block := fail[_]
	resource := concat(".", block.Labels)
} 

has_attribute(key, value) {
  _ = key[value]
}

pass[resource]{
    resource := input[_]
	isvalid(resource)
    block := resource.Blocks[_]
    block.Type == "server_side_encryption"
    block.Attributes.enabled == true
    has_attribute(block.Attributes, "kms_key_arn")
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "'aws_dynamodb_table' is encrypted using KMS Customer Managed CMK",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_dynamodb_table'is not encrypted using KMS Customer Managed CMKit",
                "snippet": block }
}
