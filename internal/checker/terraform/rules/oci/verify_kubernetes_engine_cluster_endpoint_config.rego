# METADATA
# title: "Verify that Kubernetes engine cluster is configured with NSG(s)"
# description: "By associating the Kubernetes Engine cluster with Network Security Groups (NSGs), you can ensure granular control over inbound and outbound network traffic, thereby enhancing the security and isolation of your cluster."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/containerengine_cluster#endpoint_config
# custom:
#   id: CB_TFOCI_025
#   severity: LOW
package lib.terraform.CB_TFOCI_025

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "oci_containerengine_cluster"
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
    resource.Blocks[_].Type == "endpoint_config"
    is_array(resource.Blocks[_].Attributes.nsg_ids)
    count(resource.Blocks[_].Attributes.nsg_ids) > 0
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "'oci_containerengine_cluster' for 'endpoint_config' is set properly.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "'oci_containerengine_cluster' for 'endpoint_config' should be set.",
                "snippet": block }
} 