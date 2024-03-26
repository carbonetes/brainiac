# METADATA
# title: "Verify all data stored in the Elasticsearch is encrypted with a CMK."
# description: "By encrypting data stored in the Elasticsearch domain with a Customer Managed Key (CMK), sensitive information remains secure and protected from unauthorized access, ensuring compliance with security standards and safeguarding the integrity of the system."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticsearch_domain
# custom:
#   id: CB_TFAWS_278
#   severity: LOW
package lib.terraform.CB_TFAWS_278

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
	block.Type == "encrypt_at_rest"
	block.Attributes.kms_key_id != ""
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "The data stored in the Elasticsearch is encrypted with a CMK.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "The data stored in the Elasticsearch is not encrypted with a CMK.",
		"snippet": block,
	}
}
