# METADATA
# title: "Verify that private_ip_google_access is enabled for Subnet"
# description: "This ensures that the private_ip_google_access feature is turned on for a subnet, allowing resources within the subnet to access Google services using private IP addresses."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_subnetwork
# custom:
#   id: CB_TFGCP_068
#   severity: LOW
package lib.terraform.CB_TFGCP_068
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

pass[block] {
    some block in input
	isvalid(block)
	block.Attributes.private_ip_google_access == true
}

fail[block] {
    some block in input
	isvalid(block)
    not pass[block]
}


passed[result] {
    some block in pass
	result := { "message": "'private_ip_google_access' is enabled for Subnet.",
                "snippet": block }
}

failed[result] {
    some block in fail
	result := { "message": "'private_ip_google_access' should be enabled for Subnet.",
                "snippet": block }
}