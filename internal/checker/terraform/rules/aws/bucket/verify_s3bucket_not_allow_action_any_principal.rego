# METADATA
# title: "Verify S3 bucket does not allow an action with any Principal"
# description: "Enforcing this check helps to maintain the principle of least privilege and ensures that only authorized entities have the necessary permissions to interact with the S3 bucket, reducing the risk of data breaches and unauthorized data modifications."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role
# custom:
#   id: CB_TFAWS_077
#   severity: CRITICAL
package lib.terraform.CB_TFAWS_077

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	supportedresource := ["aws_s3_bucket", "aws_s3_bucket_policy"]
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

allowAllPrincipal(statement) if {
	some value in statement.Principal
	value == "*"
}

allowAllPrincipal(statement) if {
	statement.Principal == "*"
}

fail contains block if {
	some block in input
	isvalid(block)
	policystr := block.Attributes.policy
	policyparsed := json.unmarshal(policystr)
	statement := policyparsed.Statement[0]
	statement.Effect != "Deny"
	allowAllPrincipal(statement)
}

pass contains block if {
	some block in input
	isvalid(block)
	not fail[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "S3 bucket does not allow an action with any Principal",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "S3 bucket should not allow an action with any Principal",
		"snippet": block,
	}
}
