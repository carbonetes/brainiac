# METADATA
# title: "Make certain that Glue Security Configuration Encryption is activated"
# description: "Three AWS glue components, including Cloudwatch, job bookmarks, and S3 buckets, have the potential to be encrypted. This check guarantees that each is properly set."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/4.8.0/docs/resources/glue_security_configuration
# custom:
#   id: CB_TFAWS_107
#   severity: HIGH
package lib.terraform.CB_TFAWS_107

import future.keywords.in 

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_glue_security_configuration"
}

has_attribute (key, value) {
    _ = key[value]
}

resource [resource]{
    block := pass[_]
	resource := concat(".", block.Labels)
} 
resource [resource]{
    block := fail[_]
	resource := concat(".", block.Labels)
} 

pass[block]{
    block := input[_]
	isvalid(block)
    encryptionConfig := block.Blocks[_]
    encryptionConfig.Type == "encryption_configuration"
    cloudWatch := encryptionConfig.Blocks[_]
    cloudWatch.Type == "cloudwatch_encryption"
    has_attribute(cloudWatch.Attributes, "cloudwatch_encryption_mode")
    has_attribute(cloudWatch.Attributes, "kms_key_arn")
    cloudWatch.Attributes.cloudwatch_encryption_mode == "SSE-KMS"
    cloudWatch.Attributes.kms_key_arn == "aws_kms_key.example.arn"
    job := encryptionConfig.Blocks[_]
    job.Type == "job_bookmarks_encryption"
    has_attribute(job.Attributes, "job_bookmarks_encryption_mode")
    has_attribute(job.Attributes, "kms_key_arn")
    job.Attributes.job_bookmarks_encryption_mode == "CSE-KMS"
    job.Attributes.kms_key_arn == "aws_kms_key.example.arn"
    s3_buckets := encryptionConfig.Blocks[_]
    s3_buckets.Type == "s3_encryption"
    has_attribute(s3_buckets.Attributes, "s3_encryption_mode")
}


fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}


passed[result] {
	block := pass[_]
	result := { "message": "'aws_glue_security_configuration' is encrypted.",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_glue_security_configuration' should be encrypted.",
                "snippet": block}
}
