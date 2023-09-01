# METADATA
# title: "Verify S3 buckets should have event notifications enabled"
# description: "Enabling event notifications enhances operational visibility, automation, and integration capabilities, as it allows various AWS services and external systems to respond to changes in the S3 bucket in real-time."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_notification
# custom:
#   id: CB_TFAWS_363
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_363

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
    resource.Labels[_] == "aws_s3_bucket_notification"
    label := getS3BucketLabel[_]
    contains(resource.Attributes.bucket, label)
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
	result := { "message": "S3 buckets has a event notifications enabled.",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "S3 buckets should have event notifications enabled.",
                "snippet": block }
}
