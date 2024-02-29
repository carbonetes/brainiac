# METADATA
# title: "Verify S3 bucket server-side-encryption is enabled"
# description: "This policy audits S3 buckets for Server-Side Encryption (SSE) to enhance security by encrypting data at rest, ensuring protection for stored files and directories transparently to users."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-s3-bucket.html
# custom:
#   id: CB_CFT_010
#   severity: LOW
package lib.cloudformation.CB_CFT_010
import future.keywords.in

resource := "AWS::S3::Bucket"

is_valid {
    some resources in input.Resources
    resources.Type == resource
}

pass[resources] {
    is_valid
    some resources in input.Resources
    bucket_encryption := resources.Properties.BucketEncryption
    bucket_encryption != null
    bucket_encryption.ServerSideEncryptionConfiguration != null
    count(bucket_encryption.ServerSideEncryptionConfiguration) > 0
    some enc in bucket_encryption.ServerSideEncryptionConfiguration 
    enc.ServerSideEncryptionByDefault.SSEAlgorithm == "AES256"
    
}

fail[resources] {
    resources := input.Resources
    is_valid
    count(pass) == 0
}

passed[result] {
    some block, resource in pass
    result := {
        "message": "Server-side encryption is successfully configured with AES256 for the S3 bucket.",
        "snippet": block,
    }
}

failed[result] {
    some block in fail
    result := {
        "message": "Server-side encryption must be configured for the S3 bucket.",
        "snippet": block,
    }
}
