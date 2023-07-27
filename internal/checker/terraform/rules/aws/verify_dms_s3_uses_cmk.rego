# METADATA
# title: "Verify DMS S3 uses Customer Managed Key (CMK)"
# description: "By using a CMK, you can have greater control over the encryption keys and enhance the security of your data during migration."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dms_s3_endpoint#kms_key_arn
# custom:
#   id: CB_TFAWS_263
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_263

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_dms_s3_endpoint"
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
    resource.Attributes.kms_key_arn != ""
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "DMS S3 uses Customer Managed Key (CMK).",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "DMS S3 must use Customer Managed Key (CMK).",
                "snippet": block }
} 