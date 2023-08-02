# METADATA
# title: "Verify that the DMS endpoint utilizes a Customer Managed Key (CMK) for encryption"
# description: "This check verifies that the AWS Database Migration Service (DMS) endpoint utilizes a Customer Managed Key (CMK) for encryption, enhancing the security of sensitive data during migration."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dms_endpoint
# custom:
#   id: CB_TFAWS_289
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_289

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_dms_endpoint"
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
    resource.Attributes.engine_name == "s3"
    resource.Blocks[_].Type == "s3_settings"
    has_attribute(resource.Blocks[_].Attributes, "server_side_encryption_kms_key_id")
}

pass[resource]{
    resource := input[_]
	isvalid(resource)
    resource.Attributes.engine_name != "s3"
    resource.Blocks[_].Type == "kms_key_arn"
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "A Customer Managed Key (CMK) is utilized by the DMS endpoint for encryption.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "A Customer Managed Key (CMK) must be utilized by the DMS endpoint for encryption.",
                "snippet": block }
} 