# METADATA
# title: "Verify that KMS encryption with a customer managed key (CMK) is employed for DynamoDB table replica encryption"
# description: "Ensure DynamoDB table replicas are encrypted using customer managed keys (CMKs) for enhanced data protection."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table_replica.html
# custom:
#   id: CB_TFAWS_246
#   severity: HIGH
package lib.terraform.CB_TFAWS_246

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_dynamodb_table_replica"
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
    has_attribute(resource.Attributes, "kms_key_arn")
    resource.Attributes.kms_key_arn != ""
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "DynamoDB table replica is utilizing CMK for encryption.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "DynamoDB table replica must utilize CMK for encryption.",
                "snippet": block }
} 