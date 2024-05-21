# METADATA
# title: "Verify load balancer is enabled"
# description: "This policy ensures that the load balancer service is enabled in the configuration. Disabling the load balancer can disrupt the distribution of incoming traffic among backend servers, potentially leading to service unavailability or degraded performance. By enforcing this policy, the system maintains its resilience and ability to handle incoming requests efficiently." 
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/lb_service
# custom:
#   id: CB_TFIBM_101
#   severity: MEDIUM 
package lib.terraform.CB_TFIBM_101

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	supported_resource := ["ibm_lb_service", "test_lb_local_service"]
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

pass contains resource if {
	some resource in input
	isvalid(resource)
	attribute := resource.Attributes
    "enabled" in object.keys(attribute)
    attribute.enabled == true
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "Load balancer is enabled",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Load balancer is not enabled",
		"snippet": block,
	}
}