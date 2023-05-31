# METADATA
# title: "S3 Bucket has an ACL defined which allows public WRITE access."
# description: ""
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl
# custom:
#   id: CB_TFAWS_055
#   severity: HIGH
package lib.terraform.CB_TFAWS_055

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
    resource.Attributes.acl == "public-read-write"
}


pass[block] {
    block := input[_]
	isvalid(block)
   	not fail[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "'aws_s3_bucket_acl' is set properly.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_s3_bucket_acl' should not be set with write access.",
                "snippet": block }
} 