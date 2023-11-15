# METADATA
# title: "Verify that Private google access is enabled for IPV6"
# description: "This ensures that resources within a Virtual Private Cloud (VPC) can access Google services over IPv6 using Private Google Access."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_subnetwork
# custom:
#   id: CB_TFGCP_073
#   severity: LOW
package lib.terraform.CB_TFGCP_073
import future.keywords.in

isvalid(block){
	block.Type == "resource"
    "google_compute_subnetwork" in block.Labels
}

resource[resource] {
	some block in pass
	resource := concat(".", block.Labels)
}

resource[resource] {
	some block in fail
	resource := concat(".", block.Labels)
}

fail[block] {
    some block in input
	isvalid(block)
	block.Attributes.purpose != "INTERNAL_HTTPS_LOAD_BALANCER"
	block.Attributes.stack_type == "IPV4_IPV6"
	valid_values := ["ENABLE_OUTBOUND_VM_ACCESS_TO_GOOGLE", "ENABLE_BIDIRECTIONAL_ACCESS_TO_GOOGLE"]
	not block.Attributes.private_ipv6_google_access in valid_values
}

fail[block] {
    some block in input
	isvalid(block)
	block.Attributes.stack_type == "IPV4_IPV6"
	valid_values := ["ENABLE_OUTBOUND_VM_ACCESS_TO_GOOGLE", "ENABLE_BIDIRECTIONAL_ACCESS_TO_GOOGLE"]
	not block.Attributes.private_ipv6_google_access in valid_values
}

pass[block] {
    some block in input
	isvalid(block)
    not fail[block]
}


passed[result] {
    some block in pass
	result := { "message": "Private google access is enabled for IPV6.",
                "snippet": block }
}

failed[result] {
    some block in fail
	result := { "message": "Private google access should enabled for IPV6.",
                "snippet": block }
}