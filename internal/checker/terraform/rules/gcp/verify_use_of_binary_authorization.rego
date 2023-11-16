# METADATA
# title: "Verify use of Binary Authorization"
# description: "This ensures that only authorized and signed container images are deployed, enhancing security by preventing the execution of unauthorized or untrusted code in a Kubernetes environment."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_cluster
# custom:
#   id: CB_TFGCP_058
#   severity: MEDIUM
package lib.terraform.CB_TFGCP_058
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
	block.Attributes.enable_binary_authorization == true
}

fail[block] {
    some block in input
	isvalid(block)
    not pass[block]
}


passed[result] {
    some block in pass
	result := { "message": "Binary authorization is used.",
                "snippet": block }
}

failed[result] {
    some block in fail
	result := { "message": "Binary authorization shoul be enabled.",
                "snippet": block }
}