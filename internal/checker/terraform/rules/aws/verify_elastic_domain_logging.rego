# METADATA
# title: "Verify that Elasticsearch Domain Logging is enabled"
# description: "By enabling logging for the Elasticsearch domain and directing logs to CloudWatch, you can easily monitor and analyze the activity and performance of your Elasticsearch cluster."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group
# custom:
#   id: CB_TFAWS_080
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_080

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	supportedresource := ["aws_elasticsearch_domain", "aws_opensearch_domain"]
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

pass contains resource if {
	some resource in input
	isvalid(resource)
	some block in resource.Blocks
	block.Type == "log_publishing_options"
	has_cloudwatch_log_group_arn(block.Attributes, "cloudwatch_log_group_arn")
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

has_cloudwatch_log_group_arn(key, value) := result if {
	_ = key[value]
	result := is_enabled(key, "enabled")
} else := result if {
	result := true
}

is_enabled(key, value) := result if {
	enabled := key[value]
	enabled == true
	result := true
} else := result if {
	enabled := key[value]
	enabled == false
	result := false
} else := result if {
	result := true
}

passed contains result if {
	some block in pass
	result := {
		"message": "'aws_elasticsearch_domain' or 'aws_opensearch_domain' for 'cloudwatch_log_group_arn' is set properly.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "'aws_elasticsearch_domain' 'aws_opensearch_domain' for 'cloudwatch_log_group_arn' should be set.",
		"snippet": block,
	}
}