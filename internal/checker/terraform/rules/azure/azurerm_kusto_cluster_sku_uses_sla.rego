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

supportedResources := ["azurerm_kusto_cluster"]

isvalid(block) {
    block.Type == "resource"
    some label in block.Labels
    label in supportedResources
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
    some innerblock in resource.Blocks
    innerblock.Type == "sku"
    
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
    innerblock.Attributes.name == "Dev(No SLA)_Standard_E2a_v4"
}

fail[resource] {
    some resource in input
    isvalid(resource)
    some innerblock in resource.Blocks
    innerblock.Attributes.name == "Dev(No SLA)_Standard_D11_v2"
}

passed[result] {
    some block in pass
    result := {"message": "Azure Data Explorer (ADX) is configured with an SLA-backed SKU, ensuring higher performance and reliability."}
}

failed[result] {
    some block in fail
    result := {"message": "Azure Data Explorer (ADX) should be configured with an SLA-backed SKU to guarantee better performance and reliability."}
}