# METADATA
# title: "Make certain that the ECR policy is not set to public"
# description: "To help prevent data leaking, it is advised that you restrict public access to ECR repositories."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository_policy
# custom:
#   id: CB_TFAWS_029
#   severity: INFO
package lib.terraform.CB_TFAWS_029

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_ecr_repository_policy"
}

resource contains resource if {
	some block in pass
	resource := concat(".", block.Labels)
}

resource contains resource if {
	some block in fail
	resource := concat(".", block.Labels)
}

fail contains block if {
	some block in input
	isvalid(block)
	policystr := block.Attributes.policy
	policyparsed := json.unmarshal(policystr)
	statement := policyparsed.Statement[0]
	statement.Effect == "Allow"
	principal := statement.Principal
	principal == "*"
}

pass contains block if {
	some block in input
	isvalid(block)
	not fail[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "ECS repositories are configured to disallow public access.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "ECS repositories should be configured to disallow public access.",
		"snippet": block,
	}
}

