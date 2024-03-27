# METADATA
# title: "Confirm that Fine-Grained Access Control is Activated for AWS ElasticSearch/OpenSearch"
# description: "Verify that AWS ElasticSearch/OpenSearch is configured with fine-grained access control enabled. This security measure enhances data protection by enforcing precise access permissions to the Elasticsearch/OpenSearch resources."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticsearch_domain
# custom:
#   id: CB_TFAWS_353
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_353

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
	isvalid(resource)
	some block in resource.Blocks
	block.Type == "advanced_security_options"
	block.Attributes.enabled == true
	block.Attributes.internal_user_database_enabled == true
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "The Fine-Grained Access Control is Activated for AWS ElasticSearch/OpenSearch.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "The Fine-Grained Access Control must Activated for AWS ElasticSearch/OpenSearch.",
		"snippet": block,
	}
}
