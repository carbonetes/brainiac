# METADATA
# title: "Verify that security group has stateless ingress security rules"
# description: "By defining stateless ingress security rules using OCI security groups, we ensure controlled and explicit access to network resources, enhancing the overall security posture of the infrastructure."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/keshavy1894/testoci/latest/docs/resources/core_network_security_group_security_rule#destination
# custom:
#   id: CB_TFOCI_021
#   severity: LOW
package lib.terraform.CB_TFOCI_021

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "oci_core_network_security_group_security_rule"
    has_attribute(block.Attributes, "direction")
    block.Attributes.direction == "INGRESS"
}

has_attribute(key, value) {
  _ = key[value]
}

resource[resource] {
    block := pass[_]
	resource := concat(".", block.Labels)
} 

resource[resource] { 
    block := fail[_]
	resource := concat(".", block.Labels)
}

pass[resource] {
	resource := input[_]
    isvalid(resource)

    resource.Attributes.stateless == true
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "'oci_core_network_security_group_security_rule' for 'direction' is set properly.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "'oci_core_network_security_group_security_rule' for 'direction' should be set.",
                "snippet": block }
} 