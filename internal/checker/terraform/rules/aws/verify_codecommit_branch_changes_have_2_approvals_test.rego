package lib.terraform.CB_TFAWS_239
import rego.v1

test_codecommit_branch_changes_have_2_approvals if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_codecommit_approval_rule_template",
			"example",
		],
		"Attributes": {"content": "{\n    \"Version\": \"2018-11-08\",\n    \"DestinationReferences\": [\"refs/heads/master\"],\n    \"Statements\": [{\n        \"Type\": \"Approvers\",\n        \"NumberOfApprovalsNeeded\": 2,\n        \"ApprovalPoolMembers\": [\"arn:aws:sts::123456789012:assumed-role/CodeCommitReview/*\"]\n    }]\n}\n"},
		"Blocks": [],
		"line_range": {
			"endLine": 13,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_codecommit_branch_changes_have_less_than_2_approvals if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_codecommit_approval_rule_template",
			"example",
		],
		"Attributes": {"content": "{\n    \"Version\": \"2018-11-08\",\n    \"DestinationReferences\": [\"refs/heads/master\"],\n    \"Statements\": [{\n        \"Type\": \"Approvers\",\n        \"NumberOfApprovalsNeeded\": 1,\n        \"ApprovalPoolMembers\": [\"arn:aws:sts::123456789012:assumed-role/CodeCommitReview/*\"]\n    }]\n}\n"},
		"Blocks": [],
		"line_range": {
			"endLine": 13,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
