# METADATA
# title: "Verify that OCI security groups rules do not allow ingress from 0.0.0.0/0 to port 22"
# description: "By implementing restrictions on ingress traffic in the OCI security group rules, we significantly enhance the security posture of our infrastructure by preventing unauthorized access to sensitive services."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/keshavy1894/testoci/latest/docs/resources/core_network_security_group_security_rule#destination
# custom:
#   id: CB_TFOCI_022
#   severity: LOW
package lib.terraform.CB_TFOCI_022
import future.keywords.if

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "oci_core_network_security_group_security_rule"
    is_direction(block.Attributes)
}

is_direction(attributes) := result if {
    has_attribute(attributes, "direction")
    attributes.direction == "INGRESS"
    result := true
} else := result if {
    has_attribute(attributes, "direction")
    attributes.direction != "INGRESS"
    result := false
} else := result if {
    result := true
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
    port_range_check(resource.Blocks, resource.Attributes)
}

port_range_check(blocks, attributes) := result if {
    attributes.source != "0.0.0.0/0"
    result := true
} else := result if {
    blocks[_].Type == "tcp_options"
    blocks[_].Blocks[_].Type == "destination_port_range"
    tcp_options := blocks[_].Blocks[_].Attributes
    port_check(tcp_options)
    result := false
} else := result if {
    blocks[_].Type == "udp_options"
    blocks[_].Blocks[_].Type == "destination_port_range"
    udp_options := blocks[_].Blocks[_].Attributes
    port_check(udp_options)
    result := false
} else := result if {
    result := true
}

port_check(attributes) {
	port := 22

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
	result := { "message": "'oci_core_network_security_group_security_rule' for 'destination_port_range' is set properly.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "'oci_core_network_security_group_security_rule' for 'destination_port_range' should be set.",
                "snippet": block }
} 