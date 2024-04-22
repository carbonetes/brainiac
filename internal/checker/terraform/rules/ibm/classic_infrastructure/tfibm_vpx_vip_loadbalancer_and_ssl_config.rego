# METADATA
# title: "Verify load balancer types and SSL configuration is valid"
# description: "This policy ensures the integrity and security of the load balancer configuration by verifying the validity of resource types and validating the SSL configuration, including the presence and format of the security certificate." 
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/lb_vpx_vip
# custom:
#   id: CB_TFIBM_070
#   severity: MEDIUM    
package lib.terraform.CB_TFIBM_070

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	supported_resource := ["ibm_lb_vpx_vip", "testacc_vip"]
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
	"type" in object.keys(attribute)
    value := ["HTTP", "FTP", "TCP", "UDP", "DNS"]
    attribute.type in value
}

pass contains resource if {
	some resource in input
	isvalid(resource)
	attribute := resource.Attributes
	"type" in object.keys(attribute)
    attribute.type == "SSL"
    attribute.security_certificate_id != ""
    not regex.match(`[A-Z]+`, attribute.security_certificate_id)
	not regex.match(`[a-z]+`, attribute.security_certificate_id)
	not regex.match(`[_\-|@.,?/!~#$%^&*(){}\[\]=]+`, attribute.security_certificate_id)
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "Load balancer configuration is valid",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Load balancer configuration is not valid",
		"snippet": block,
	}
}