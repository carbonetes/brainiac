# METADATA
# title: "A Public Access block must be present in the S3 bucket"
# description: "Setting the extra resource aws_s3_bucket_public_access_block when creating an S3 bucket is recommended to make sure the bucket is never unintentionally made public."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket.html
# custom:
#   id: CB_TFAWS_328
#   severity: LOW
package lib.terraform.CB_TFAWS_328

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_s3_bucket"
}

resource[resource] {
    block := pass[_]
	resource := concat(".", block.Labels)
} 

resource[resource] { 
    block := fail[_]
	resource := concat(".", block.Labels)
} 

isValidResourceAttached{
    resource := input[_]
    resource.Type == "resource"
    resource.Labels[_] == "aws_s3_bucket_public_access_block"
    resource.Attributes.block_public_acls == true
    resource.Attributes.block_public_policy == true
}

pass[resource]{
    resource := input[_]
    isvalid(resource)
    isValidResourceAttached
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "Public Access block is present in the S3 bucket.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "Public Access block must be present in the S3 bucket.",
                "snippet": block }
} 