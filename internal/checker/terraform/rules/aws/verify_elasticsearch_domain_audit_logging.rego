# METADATA
# title: "Verify that Elasticsearch Domain Logging is enabled"
# description: "By enabling Elasticsearch Domain Audit Logging with the property of `log_publishing_options` and `log_type` set to `AUDIT_LOGS` in Terraform, it is important to enhance security and compliance by capturing and monitoring critical activities and access patterns within the Elasticsearch domain."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticsearch_domain
# custom:
#   id: CB_TFAWS_304
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_304

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
    resource.Blocks[_].Attributes.log_type == "AUDIT_LOGS"
    resource.Blocks[_].Attributes.enabled == true
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "Elasticsearch Domain Audit Logging is enabled.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "Elasticsearch Domain Audit Logging should be enabled.",
                "snippet": block }
} 