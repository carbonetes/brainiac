# METADATA
# title: "Verify that OCI security list does not allow ingress from 0.0.0.0/0 to port 3389"
# description: "By restricting ingress traffic from `0.0.0.0/0` to port 3389 in the OCI security list, potential unauthorized access to the SSH service is effectively mitigated, enhancing the overall security posture of the system."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_security_list#ingress_security_rules
# custom:
#   id: CB_TFOCI_020
#   severity: HIGH
package lib.terraform.CB_TFOCI_020

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "oci_core_security_list"
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

    resource.Blocks[_].Type == "ingress_security_rules"
    has_attribute(resource.Blocks[_].Attributes, "protocol")
    resource.Blocks[_].Attributes.source != "0.0.0.0/0"
}

pass[resource] {
	resource := input[_]
    isvalid(resource)

    resource.Blocks[_].Type == "ingress_security_rules"
    has_attribute(resource.Blocks[_].Attributes, "protocol")

    tcp_options := resource.Blocks[_].Blocks[_]
    tcp_options.Type == "tcp_options"
    not port_check(tcp_options.Attributes)

    udp_options := resource.Blocks[_].Blocks[_]
    udp_options.Type == "udp_options"
    not port_check(udp_options.Attributes)
}

port_check(attributes) {
	port := 3389

    min := to_number(attributes.min)
    max := to_number(attributes.max)

    min <= max
    min <= port
    max >= port
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
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