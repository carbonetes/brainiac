# METADATA
# title: "Verify that Elasticsearch is not using the default Security Group."
# description: "By customizing the VPC options and security group IDs for the Elasticsearch domain, we ensure that the Elasticsearch service is securely integrated within our own VPC network, providing better control and isolation over access to the service, enhancing overall security and compliance."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticsearch_domain#security_group_ids
# custom:
#   id: CB_TFAWS_279
#   severity: LOW
package lib.terraform.CB_TFAWS_279

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
	block.Type == "vpc_options"
	is_array(block.Attributes.security_group_ids)
	count(block.Attributes.security_group_ids) > 0
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "Elasticsearch is not using the default Security Group.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Elasticsearch must not use the default Security Group.",
		"snippet": block,
	}
}
