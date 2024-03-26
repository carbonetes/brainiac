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

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	supported_resources := ["aws_elasticsearch_domain", "aws_opensearch_domain"]
	label in supported_resources
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
	resource.Blocks[_].Type == "log_publishing_options"
	resource.Blocks[_].Attributes.log_type == "AUDIT_LOGS"
	resource.Blocks[_].Attributes.enabled == true
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "Elasticsearch Domain Audit Logging is enabled.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Elasticsearch Domain Audit Logging should be enabled.",
		"snippet": block,
	}
}
