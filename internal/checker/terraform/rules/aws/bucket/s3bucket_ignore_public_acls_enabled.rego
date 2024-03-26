# METADATA
# title: "Verify S3 bucket has ignore public ACLs enabled"
# description: "This means that the bucket will not grant access to any unauthorized users, even if the user has public access permissions set. "
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block#ignore_public_acls
# custom:
#   id: CB_TFAWS_052
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_052

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
	resource.Attributes.ignore_public_acls == true
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "'aws_s3_bucket_public_access_block' 'ignore_public_acls' is set properly.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "'aws_s3_bucket_public_access_block' 'ignore_public_acls' should be set to true",
		"snippet": block,
	}
}
