# METADATA
# title: "Verify Glue component has a security configuration associated"
# description: "Checks if the AWS Glue component has a security configuration associated."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-glue-crawler.html
# custom:
#   id: CB_CFT_118
#   severity: HIGH
package lib.cloudformation.CB_CFT_118

import future.keywords.in

is_valid {
	supported_resources := ["AWS::Glue::Crawler", "AWS::Glue::DevEndpoint", "AWS::Glue::Job"]
	some resources in input.Resources
	resources.Type in supported_resources
}

resource[type] {
	some resource in input.Resources
	is_valid
	count(fail) > 0
	type := resource.Type
}

resource[type] {
	some resource in input.Resources
	is_valid
	count(pass) > 0
	type := resource.Type
}

fail[block] {
	is_valid
	some resources in input.Resources
	block := resources.Properties
	not block.SecurityConfiguration
}

pass[resources] {
	some resources in input.Resources
	is_valid
	count(fail) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "Glue component has a security configuration associated.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Glue component should have a security configuration associated.",
		"snippet": block,
	}
}
