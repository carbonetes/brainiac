# METADATA
# title: "Verify Data fusion instances are private"
# description: "This ensures that Google Cloud Data Fusion instances operate within a private network environment, enhancing security by restricting external access and mitigating potential vulnerabilities."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/data_fusion_instance
# custom:
#   id: CB_TFGCP_091
#   severity: LOW
package lib.terraform.CB_TFGCP_091
import future.keywords.in

isvalid(block){
	block.Type == "resource"
    "google_data_fusion_instance" in block.Labels
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
	block.Attributes.private_instance == true
}

fail[block] {
    some block in input
	isvalid(block)
    not pass[block]
}


passed[result] {
    some block in pass
	result := { "message": "Data fusion instances are private.",
                "snippet": block }
}

failed[result] {
    some block in fail
	result := { "message": "Data fusion instances should be set to private.",
                "snippet": block }
}