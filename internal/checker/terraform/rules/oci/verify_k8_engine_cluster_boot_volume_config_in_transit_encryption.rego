# METADATA
# title: "Verify that Kubernetes Engine Cluster boot volume is configured with in-transit data encryption"
# description: "By enabling in-transit data encryption for the boot volume of the Kubernetes Engine cluster, sensitive data remains secure during transit, ensuring the confidentiality and integrity of the data as it moves between nodes, reducing the risk of unauthorized access or tampering."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/containerengine_node_pool#node_config_details
# custom:
#   id: CB_TFOCI_027
#   severity: MEDIUM
package lib.terraform.CB_TFOCI_027

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "oci_containerengine_node_pool"
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
    resource.Blocks[_].Type == "node_config_details"
    resource.Blocks[_].Attributes.is_pv_encryption_in_transit_enabled == true
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "'oci_containerengine_node_pool' for 'node_config_details' is set properly.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "'oci_containerengine_node_pool' for 'node_config_details' should be set.",
                "snippet": block }
} 