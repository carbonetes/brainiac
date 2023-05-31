# METADATA
# title: "Verify S3 bucket has 'restrict_public_bucket' enabled"
# description: "This check helps to improve the security posture of the S3 bucket and reduce the risk of data breaches or unauthorized access."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block#ignore_public_acls
# custom:
#   id: CB_TFAWS_053
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_053

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
    resource.Attributes.restrict_public_buckets == true
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "'aws_s3_bucket_public_access_block' 'restrict_public_buckets' is set properly.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_s3_bucket_public_access_block' 'restrict_public_buckets' should be set to true",
                "snippet": block }
} 