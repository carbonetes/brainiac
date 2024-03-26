# METADATA
# title: "Verify that Elasticsearch Domain enforces HTTPS"
# description: "By enforcing HTTPS, the Elasticsearch Domain guarantees secure communication and data transfer, ensuring the encryption of sensitive information and preventing unauthorized access."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticsearch_domain
# custom:
#   id: CB_TFAWS_068
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_068

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

fail contains resource if {
	some resource in input
	isvalid(resource)
	some blocks in resource.Blocks
	blocks.Type == "domain_endpoint_options"
	blocks.Attributes.enforce_https == false
}

pass contains block if {
	some block in input
	isvalid(block)
	not fail[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "'aws_elasticsearch_domain' or 'aws_opensearch_domain' for 'enforce_https' is set properly.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "'aws_elasticsearch_domain' 'aws_opensearch_domain' for 'enforce_https' should be set.",
		"snippet": block,
	}
}