# METADATA
# title: "Verify Elasticsearch Domain Logging is enabled"
# description: "Checks if the LogPublishingOptions property of an Elasticsearch Domain is set to true"
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-elasticsearch-domain.html
# custom:
#   id: CB_CFT_065
#   severity: MEDIUM
package lib.cloudformation.CB_CFT_065

import future.keywords.in

is_valid {
	supported_resources := ["AWS::Elasticsearch::Domain", "AWS::OpenSearchService::Domain"]
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

pass[log] {
	is_valid
	some resources in input.Resources
	some log in resources.Properties.LogPublishingOptions
	log.Enabled == true
}

fail[resources] {
	some resources in input.Resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "Elasticsearch Domain Logging is enabled.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Elasticsearch Domain Logging is not enabled.",
		"snippet": block,
	}
}
