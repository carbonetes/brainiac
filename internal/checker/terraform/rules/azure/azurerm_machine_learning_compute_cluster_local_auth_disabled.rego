# METADATA
# title: "Verify that Machine Learning Compute Cluster Local Authentication is deactivated"
# description: "Confirm that Machine Learning Compute Cluster Local Authentication is deactivated, bolstering security by preventing unauthorized access to cluster resources."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/machine_learning_compute_cluster
# custom:
#   id: CB_TFAZR_149
#   severity: LOW
package lib.terraform.CB_TFAZR_149

import future.keywords.in


isvalid(block){
	block.Type == "resource"
    "azurerm_machine_learning_compute_cluster" in block.Labels
}

resource[resource] {
    some block in pass
	resource := concat(".", block.Labels)
} 

resource[resource] { 
    some block in fail
	resource := concat(".", block.Labels)
} 

pass[block]{
    some block in input
	isvalid(block)
    block.Attributes.local_auth_enabled == false
}

fail[block] {
    some block in input
	isvalid(block)
   	not pass[block]
}

passed[result] {
	some block in pass
	result := { 
        "message": "The Machine Learning Compute Cluster Local Authentication is deactivated.",
        "snippet": block, 
    }
}

failed[result] {
    some block in fail
	result := { 
        "message": "The Machine Learning Compute Cluster Local Authentication is activated, it must be deactivated.",
        "snippet": block, 
    }
} 