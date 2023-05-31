# METADATA
# title: "Verify the S3 bucket has access logging enabled"
# description: "Enabling access logging for an S3 bucket provides visibility into who is accessing the data and when."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_logging
# custom:
#   id: CB_TFAWS_023
#   severity: LOW
package lib.terraform.CB_TFAWS_023

import future.keywords.in 


isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_s3_bucket"
}
isS3Logging(block){
	block.Type == "resource"
    block.Labels[_] == "aws_s3_bucket_logging"
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
    block.Type == "logging"
}

pass[resource]{
    resource := input[_]
	isS3Logging(resource)
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
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