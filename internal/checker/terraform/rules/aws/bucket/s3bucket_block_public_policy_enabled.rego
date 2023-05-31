# METADATA
# title: "Verify S3 bucket has block public policy enabled"
# description: " By blocking public policies, you reduce the risk of unauthorized access to sensitive data that may be stored in the S3 bucket."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block#block_public_policy
# custom:
#   id: CB_TFAWS_051
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_051

import future.keywords.in 


isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_s3_bucket_public_access_block"
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
    resource.Attributes.block_public_policy == true
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "'aws_s3_bucket_public_access_block' 'block_public_policy' is set properly.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_s3_bucket_public_access_block' 'block_public_policy' should be set to true",
                "snippet": block }
} 