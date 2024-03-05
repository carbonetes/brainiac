# METADATA
# title: "Make certain that the Threat Detection policy is activated on your MySQL server"
# description: "Verify that your MySQL server has activated the Threat Detection policy, enhancing its security measures by proactively identifying and mitigating potential threats, safeguarding your data and infrastructure."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mysql_server
# custom:
#   id: CB_TFAZR_100
#   severity: LOW
package lib.terraform.CB_TFAZR_100

import future.keywords.in

isvalid(block){
	block.Type == "resource"
    "azurerm_mysql_server" in block.Labels
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
    some innerBlock in block.Blocks
    innerBlock.Type == "threat_detection_policy"
    innerBlock.Attributes.enabled == true
}

fail[block] {
    some block in input
	isvalid(block)
   	not pass[block]
}

passed[result] {
	some block in pass
	result := { 
        "message": "The Threat Detection policy is activated on your MySQL server.",
        "snippet": block, 
    }
}

failed[result] {
    some block in fail
	result := { 
        "message": "The Threat Detection policy is not activated on your MySQL server.",
        "snippet": block, 
    }
} 