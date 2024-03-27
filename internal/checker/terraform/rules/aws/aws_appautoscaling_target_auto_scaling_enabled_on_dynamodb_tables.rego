# METADATA
# title: "Check to see if Auto Scaling is activated for your DynamoDB tables"
# description: "Determines if DynamoDB tables are configured for autoscaling. Keep in mind that such setup is automatically included for tables with billing_mode = PAY_PER_REQUEST."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table
# custom:
#   id: CB_TFAWS_350
#   severity: LOW
package lib.terraform.CB_TFAWS_350

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_dynamodb_table"
}

resource contains resource if {
	some block in pass
	resource := concat(".", block.Labels)
}

resource contains resource if {
	some block in fail
	resource := concat(".", block.Labels)
}

has_attribute(key, value) if {
	value in object.keys(key)
}

getthelabelforawsdynamodbtable contains label if {
	some resource in input
	resource.Type == "resource"
	"aws_dynamodb_table" in resource.Labels
	resource.Attributes.billing_mode == "PROVISIONED"
	label := concat(".", resource.Labels)
}

getthelabelforawsdynamodbtable contains label if {
	some resource in input
	resource.Type == "resource"
	"aws_dynamodb_table" in resource.Labels
	not has_attribute(resource.Attributes, "billing_mode")
	label := concat(".", resource.Labels)
}

isawsappautoscalingtargetandpolicyattachedfordynamodb if {
	some resource in input
	resource.Type == "resource"
	"aws_appautoscaling_target" in resource.Labels
	some label in getthelabelforawsdynamodbtable
	contains(resource.Attributes.resource_id, label)
	policyisattached
}

getlabelforscalingtarget contains label if {
	some resource in input
	resource.Type == "resource"
	"aws_appautoscaling_target" in resource.Labels
	resource.Attributes.service_namespace == "dynamodb"
	label := concat(".", resource.Labels)
}

policyisattached if {
	some resource in input
	resource.Type == "resource"
	"aws_appautoscaling_policy" in resource.Labels
	some label in getlabelforscalingtarget
	contains(resource.Attributes.resource_id, label)
}

pass contains resource if {
	some resource in input
	isvalid(resource)
	isawsappautoscalingtargetandpolicyattachedfordynamodb
}

pass contains resource if {
	some resource in input
	isvalid(resource)
	resource.Attributes.billing_mode == "PAY_PER_REQUEST"
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "The Auto Scaling is activated for your DynamoDB tables.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "The Auto Scaling must be activated for your DynamoDB tables.",
		"snippet": block,
	}
}
