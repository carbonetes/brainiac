# METADATA
# title: "Verify port on Protocol is secured"
# description: "This policy mandates verifying the security of the designated protocol port, ensuring it supports either HTTPS for encrypted communication or HTTP for unencrypted communication. Adherence to this policy enhances network security by enforcing consistent standards and mitigating risks associated with insecure communication protocols."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/cdn
# custom:
#   id: CB_TFIBM_039
#   severity: HIGH
package lib.terraform.CB_TFIBM_039

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	supported_resource := ["ibm_cdn", "test_cdn1"]
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
    valid := ["HTTP", "HTTPS"]
    attribute.protocol in valid
    https(attribute)
	attribute.http_port >= 80
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "Protocol port is secured",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Protocol port is not secured",
		"snippet": block,
	}
}