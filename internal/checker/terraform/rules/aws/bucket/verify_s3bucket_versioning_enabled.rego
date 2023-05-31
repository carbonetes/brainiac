# METADATA
# title: "Make sure that the S3 bucket has versioning enabled for all data stored in it."
# description: "Enabling versioning for an S3 bucket ensures that every object stored in the bucket is assigned a unique version ID, allowing you to preserve, retrieve, and restore previous versions of the object. "
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning
# custom:
#   id: CB_TFAWS_038
#   severity: HIGH
package lib.terraform.CB_TFAWS_038

import future.keywords.in 

supportedResource := ["aws_s3_bucket", "aws_s3_bucket_versioning"]

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

pass[resource]{
    resource := input[_]
	isvalid(resource)
    block := resource.Blocks[_]
    block.Type == "versioning"
    block.Attributes.enabled == true
}

pass[resource]{
    resource := input[_]
	isvalid(resource)
    block := resource.Blocks[_]
    block.Type == "versioning_configuration"
    block.Attributes.status == "Enabled"
}

fail[block] {
    block := input[_]
	isvalid(block)
   	passCount := pass
    count(passCount) == 0
}

passed[result] {
	block := pass[_]
	result := { "message": "'aws_s3_bucket_versioning' is set properly.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_s3_bucket_versioning' should be enabled",
                "snippet": block }
} 