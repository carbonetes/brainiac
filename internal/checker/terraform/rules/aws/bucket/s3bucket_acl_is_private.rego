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

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	supportedresource := ["aws_s3_bucket", "aws_s3_bucket_acl"]
	label in supportedresource
}

resource contains resource if {
	some block in pass
	resource := concat(".", block.Labels)
}

resource contains resource if {
	some block in fail
	resource := concat(".", block.Labels)
}


fail contains resource if {
    some resource in input
	isvalid(resource)
    resource.Attributes.acl == "public-read"
}

pass contains block if {
	some block in input
	isvalid(block)
	not fail[block]
}

passed contains result if {
	some block in pass
	result := { "message": "'aws_s3_bucket' 'acl' is set properly.",
                "snippet": block }
}

failed contains result if {
	some block in fail
	result := { "message": "'aws_s3_bucket' 'acl' should be set to private",
                "snippet": block }
} 