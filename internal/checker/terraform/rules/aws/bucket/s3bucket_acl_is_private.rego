# METADATA
# title: "The S3 Bucket allows public READ access through its ACL"
# description: "This configuration allows any user to access and read data stored in the S3 Bucket, posing a significant security risk as it can result in the exposure of sensitive information."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl
# custom:
#   id: CB_TFAWS_037
#   severity: CRITICAL
package lib.terraform.CB_TFAWS_037

import future.keywords.in 


supportedResource := ["aws_s3_bucket", "aws_s3_bucket_acl"]
isvalid(block){
	block.Type == "resource"
    block.Labels[_] == supportedResource[_]
}

resource[resource] {
    block := pass[_]
	resource := concat(".", block.Labels)
} 

resource[resource] { 
    block := fail[_]
	resource := concat(".", block.Labels)
} 

fail[resource]{
    resource := input[_]
	isvalid(resource)
    resource.Attributes.acl == "public-read"
}

pass[block] {
    block := input[_]
	isvalid(block)
   	not fail[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "'aws_s3_bucket' 'acl' is set properly.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_s3_bucket' 'acl' should be set to private",
                "snippet": block }
} 