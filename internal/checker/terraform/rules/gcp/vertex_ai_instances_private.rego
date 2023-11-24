# METADATA
# title: "Verify Vertex AI instances are private"
# description: "This ensures that Vertex AI instances are configured to operate in a private network environment, enhancing security by restricting access to authorized networks and preventing exposure to the public internet."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/notebooks_instance
# custom:
#   id: CB_TFGCP_093
#   severity: HIGH
package lib.terraform.CB_TFGCP_093
import future.keywords.in

isvalid(block){
	block.Type == "resource"
    "google_notebooks_instance" in block.Labels
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
	block.Attributes.no_public_ip == true
}

fail[block] {
    some block in input
	isvalid(block)
    not pass[block]
}


passed[result] {
    some block in pass
	result := { "message": "Vertex AI instances are private.",
                "snippet": block }
}

failed[result] {
    some block in fail
	result := { "message": "Vertex AI instances should be private",
                "snippet": block }
}