# METADATA
# title: "Verify all data stored in the S3 bucket is securely encrypted at rest"
# description: "Encryption helps to protect sensitive information from unauthorized access or theft and prevents data from being compromised in case of a security breach or accidental exposure."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration
# custom:
#   id: CB_TFAWS_024
#   severity: LOW
package lib.terraform.CB_TFAWS_024

import future.keywords.in 


supportedResource := ["aws_s3_bucket", "aws_s3_bucket_server_side_encryption_configuration"]
isvalid(block){
	block.Type == "resource"
    block.Labels[_] == supportedResource[_]
}

aesImplemented(block){
	ruleBlock := block.Blocks[_]
    ruleBlock.Type = "rule"
    encryptionBlock := ruleBlock.Blocks[_]
    encryptionBlock.Type = "apply_server_side_encryption_by_default"
    encryptionBlock.Attributes.sse_algorithm == "AES256"
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
    block := resource.Blocks[_]
    block.Type == "server_side_encryption_configuration"
    aesImplemented(block)
}

pass[resource]{
    resource := input[_]
	isvalid(resource)
    aesImplemented(resource)
}

fail[block] {
    block := input[_]
	isvalid(block)
   	passCount := pass
    count(passCount) == 0
}

passed[result] {
	block := pass[_]
	result := { "message": "'aws_s3_bucket' 'logging' is set properly.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_s3_bucket' 'logging' should be set",
                "snippet": block }
} 