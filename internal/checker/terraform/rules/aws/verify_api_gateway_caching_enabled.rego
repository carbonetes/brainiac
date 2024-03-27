# METADATA
# title: "Verify API Gateway caching is enabled"
# description: "Caching allows responses from your API to be stored temporarily and served to subsequent requests, reducing the need to process the same request repeatedly."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/3.9.0/docs/resources/api_gateway_stage
# custom:
#   id: CB_TFAWS_114
#   severity: LOW
package lib.terraform.CB_TFAWS_114

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_api_gateway_stage"
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
	resource.Attributes.cache_cluster_enabled == true
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "'aws_api_gateway_stage' cache_cluster_enabled is set.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "'aws_api_gateway_stage'cache_cluster_enabled should be set to true.",
		"snippet": block,
	}
}