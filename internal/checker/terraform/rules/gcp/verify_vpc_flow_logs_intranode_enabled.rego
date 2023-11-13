# METADATA
# title: "Verify VPC Flow Logs and Intranode Visibility enabled"
# description: "Enabling VPC Flow Logs and Intranode Visibility enhances security and network monitoring, aiding in threat detection, issue resolution, and overall cloud infrastructure optimization."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_cluster
# custom:
#   id: CB_TFGCP_045
#   severity: MEDIUM
package lib.terraform.CB_TFGCP_045
import future.keywords.in

isvalid(block){
	block.Type == "resource"
    "google_container_cluster" in block.Labels
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
   	block.Attributes.enable_intranode_visibility == true
}

fail[block] {
    some block in input
	isvalid(block)
    not pass[block]
}


passed[result] {
    some block in pass
	result := { "message": "VPC Flow Logs and Intranode Visibility enabled.",
                "snippet": block }
}

failed[result] {
    some block in fail
	result := { "message": "VPC Flow Logs and Intranode Visibility should be enabled.",
                "snippet": block }
}