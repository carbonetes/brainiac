# METADATA
# title: "Verify that an S3 bucket has a lifecycle configuration"
# description: "By configuring a lifecycle policy for an S3 bucket, you can automatically transition objects to different storage classes or delete them when they're no longer needed."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration
# custom:
#   id: CB_TFAWS_362
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_362

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_s3_bucket"
}

resource [resource]{
    block := pass[_]
	resource := concat(".", block.Labels)
} 
resource [resource]{
    block := fail[_]
	resource := concat(".", block.Labels)
} 

getS3BucketLabel[label] {
    resource := input[_]
    resource.Type == "resource"
    resource.Labels[_] == "aws_s3_bucket"
    label := concat(".", resource.Labels)
}

isValidResourceAttached{
    resource := input[_]
    resource.Type == "resource"
    resource.Labels[_] == "aws_s3_bucket_lifecycle_configuration"
    label := getS3BucketLabel[_]
    contains(resource.Attributes.bucket, label)
}

pass[resource]{
    resource := input[_]
	isvalid(resource)
    isValidResourceAttached
}

pass[resource]{
    resource := input[_]
	isvalid(resource)
    resource.Blocks[_].Type == "lifecycle_rule"
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "S3 bucket has a lifecycle configuration.",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "S3 bucket should have a lifecycle configuration.",
                "snippet": block }
}
