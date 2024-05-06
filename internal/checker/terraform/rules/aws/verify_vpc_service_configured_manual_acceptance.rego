# METADATA
# title: "Verify that VPC Endpoint Service is configured for Manual Acceptance"
# description: "When the VPC Endpoint Service is set to manual acceptance, any VPC owner wanting to access the service's endpoints must explicitly request access and wait for approval from the service owner."
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/2.50.0/docs/data-sources/vpc_endpoint_service
# custom:
#   id: CB_TFAWS_119
#   severity: LOW
package lib.terraform.CB_TFAWS_119

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_vpc_endpoint_service"
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
	resource.Attributes.acceptance_required == true
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "VPC Endpoint Service is configured for Manual Acceptance.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "VPC Endpoint Service should be configured for Manual Acceptance.",
		"snippet": block,
	}
}