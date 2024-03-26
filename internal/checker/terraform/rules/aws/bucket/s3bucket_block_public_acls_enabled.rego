# METADATA
# title: "Verify S3 bucket has block public ACLS enabled"
# description: "This feature helps to prevent public access to the bucket and its objects via Access Control Lists (ACLs)."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block
# custom:
#   id: CB_TFAWS_050
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_050

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_s3_bucket_public_access_block"
}

resource contains resource if {
	some block in pass
	resource := concat(".", block.Labels)
}

resource contains resource if {
	some block in fail
	resource := concat(".", block.Labels)
}

pass contains resource if {
    some resource in input
	isvalid(resource)
    resource.Attributes.block_public_acls == true
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := { "message": "'aws_s3_bucket_public_access_block' 'block_public_acls' is set properly.",
                "snippet": block }
}

failed contains result if {
	some block in fail
	result := { "message": "'aws_s3_bucket_public_access_block' 'block_public_acls' should be set to true",
                "snippet": block }
}