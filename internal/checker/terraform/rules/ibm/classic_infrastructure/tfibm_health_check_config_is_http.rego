# METADATA
# title: "Verify health check configuration is set to HTTP"
# description: "This policy ensures that the system uses HTTP health checks, which are commonly preferred for their compatibility and effectiveness in monitoring web-based services."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/compute_autoscale_group
# custom:
#   id: CB_TFIBM_041
#   severity: MEDIUM
package lib.terraform.CB_TFIBM_041

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	supported_resource := ["ibm_compute_autoscale_group", "test_scale_group"]
	label in supported_resource
}

resource contains resource if {
	some block in pass
	resource := concat(".", block.Labels)
}

resource contains resource if {
	some block in fail
	resource := concat(".", block.Labels)
}

https(attribute) if {
	attribute.https_port >= 0
}

pass contains resource if {
	some resource in input
	isvalid(resource)
    attribute := resource.Attributes
    "health_check" in object.keys(attribute)
    health := attribute.health_check
    health.type == "HTTP"
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "Health check configuration is set to HTTP",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Health check configuration is not set to HTTP",
		"snippet": block,
	}
}