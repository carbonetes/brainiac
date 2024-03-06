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

resource := ["AWS::Elasticsearch::Domain", "AWS::OpenSearchService::Domain"]

is_valid {
	some resources in input.Resources
	some resource_type in resource
	resources.Type == resource_type
}

pass[log] {
	is_valid
	some resources in input.Resources
	some resource_type in resource
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