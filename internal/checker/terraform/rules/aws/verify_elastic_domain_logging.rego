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

import future.keywords.if

supportedResource := ["aws_elasticsearch_domain", "aws_opensearch_domain"]

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == supportedResource[_]
}

resource[resource] {
    block := pass[_]
	resource := concat(".", block.Labels)
} 

resource[resource] { 
    block := fail[_]
	resource := concat(".", block.Labels)
} 

pass[resource] {
	resource := input[_]
	resource.Blocks[_].Type == "log_publishing_options"
    has_cloudwatch_log_group_arn(resource.Blocks[_].Attributes, "cloudwatch_log_group_arn")
}

fail[block] {
    block := input[_]
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

passed[result] {
	block := pass[_]
	result := { "message": "'aws_elasticsearch_domain' or 'aws_opensearch_domain' for 'cloudwatch_log_group_arn' is set properly.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_elasticsearch_domain' 'aws_opensearch_domain' for 'cloudwatch_log_group_arn' should be set.",
                "snippet": block }
} 