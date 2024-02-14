# METADATA
# title: "Require Data Explorer to Use an SLA-Backed SKU"
# description: "Ensure that the VM Agent is correctly installed on virtual machines for enhanced management and monitoring"
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kusto_cluster
# custom:
#   id: CB_TFAZR_156
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_156

import future.keywords.in

isvalid(block) {
    block.Type == "resource"
    "azurerm_kusto_cluster" in block.Labels
}

resource[resource] {
    some block in pass
    resource := concat(".", block.Labels)
}

resource[resource] {
    some block in fail
    resource := concat(".", block.Labels)
}

pass[resource] {
    some resource in input
    isvalid(resource)
	not fail[resource]
    
}

fail[resource] {
    some resource in input
    isvalid(resource)
    some innerblock in resource.Blocks
    invalidValues := ["Dev(No SLA)_Standard_E2a_v4", "Dev(No SLA)_Standard_D11_v2"]
    innerblock.Attributes.name in invalidValues
}


passed[result] {
    some block in pass
    result := {
        "message": "Azure Data Explorer (ADX) is configured with an SLA-backed SKU, ensuring higher performance and reliability.",
	    "snippet": block,
    }
}

failed[result] {
    some block in fail
    result := {
        "message": "Azure Data Explorer (ADX) should be configured with an SLA-backed SKU to guarantee better performance and reliability.",
	    "snippet": block,
    }
}
