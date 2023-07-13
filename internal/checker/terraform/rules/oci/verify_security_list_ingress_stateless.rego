# METADATA
# title: "Verify that VCN inbound security lists are stateless"
# description: "By setting the VCN inbound security lists to be stateless, it is important to ensure that network traffic is controlled and monitored without relying on connection tracking, enhancing security and simplifying network management."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_security_list#ingress_security_rules
# custom:
#   id: CB_TFOCI_017
#   severity: HIGH
package lib.terraform.CB_TFOCI_017

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "oci_core_security_list"
    block.Blocks[_].Type == "ingress_security_rules"
}

resource[resource] {
    block := pass[_]
	resource := concat(".", block.Labels)
} 

resource[resource] { 
    block := fail[_]
	resource := concat(".", block.Labels)
}

pass[block] {
    block := input[_]
	isvalid(block)
   	not fail[block]
}

fail[resource] {
	resource := input[_]
    isvalid(resource)

    resource.Blocks[_].Attributes.stateless != true
}




passed[result] {
	block := pass[_]
	result := { "message": "'oci_core_security_list' for 'ingress_security_rules' is set properly.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "'oci_core_security_list' for 'ingress_security_rules' should be set.",
                "snippet": block }
} 