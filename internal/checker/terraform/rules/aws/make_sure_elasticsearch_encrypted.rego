# METADATA
# title: "Make sure that all data stored in Elasticsearch is encrypted securely while at rest."
# description: "This helps ensure that the data remains secure even if an attacker gains access to the storage medium where the data is stored."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticsearch_domain#encrypt_at_rest
# custom:
#   id: CB_TFAWS_004
#   severity: LOW
package lib.terraform.CB_TFAWS_004

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
    block.Type == "encrypt_at_rest"
    block.Attributes.enabled == true
}

fail contains resource if {
    some resource in input
	isvalid(resource)
   	some block in resource.Blocks
    block.Type == "encrypt_at_rest"
    block.Attributes.enabled == false
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := { "message": "encrypt_at_rest is true.",
                "snippet": block}
}

failed contains result if {
	some block in fail
	result := { "message": "encrypt_at_rest should be set to true",
                "snippet": block }
}
