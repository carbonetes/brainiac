# METADATA
# title: "Verify Elasticsearch Domain Audit Logging is enabled"
# description: "Enabling Elasticsearch Domain Audit Logging ensures a crucial security layer, allowing effective monitoring and tracking of activities within the Elasticsearch domain for enhanced protection against potential threats."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-elasticsearch-domain.html
# custom:
#   id: CB_CFT_122
#   severity: LOW
package lib.cloudformation.CB_CFT_122

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

pass[block] {
	is_valid
	some resources in input.Resources
	block := resources.Properties.LogPublishingOptions
	audit_logs = block.AUDIT_LOGS
	audit_logs.Enabled == true
}

fail[resources] {
	some resources in input.Resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "Elasticsearch Domain Audit Logging is enabled.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Elasticsearch Domain Audit Logging should be enabled.",
		"snippet": block,
	}
}
