# METADATA
# title: "Verify that Redshift clusters use enhanced VPC routing"
# description: "By enabling enhanced VPC routing for Redshift clusters, network traffic is efficiently routed through the VPC, ensuring secure and optimized communication between the cluster and other resources within the VPC."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/redshift_cluster
# custom:
#   id: CB_TFAWS_309
#   severity: LOW
package lib.terraform.CB_TFAWS_309

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_redshift_cluster"
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
	resource.Attributes.enhanced_vpc_routing == true
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "Redshift clusters use enhanced VPC routing.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Redshift clusters should use enhanced VPC routing.",
		"snippet": block,
	}
}
