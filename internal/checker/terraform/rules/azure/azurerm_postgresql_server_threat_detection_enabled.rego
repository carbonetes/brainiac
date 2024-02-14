# METADATA
# title: "Make certain that the Threat Detection policy is activated on your PostgreSQL server"
# description: "Verify that your PostgreSQL server has activated the Threat Detection policy, enhancing its security measures by actively identifying and mitigating potential threats. This proactive approach safeguards your data and database infrastructure from potential vulnerabilities and security risks."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_server
# custom:
#   id: CB_TFAZR_112
#   severity: LOW
package lib.terraform.CB_TFAZR_112

import future.keywords.in

isvalid(block){
	block.Type == "resource"
    "azurerm_postgresql_server" in block.Labels
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
        "message": "The Threat Detection policy is activated on your PostgreSQL server.",
        "snippet": block, 
    }
}

failed[result] {
    some block in fail
	result := { 
        "message": "The Threat Detection policy is inactive on your PostgreSQL server.",
        "snippet": block, 
    }
} 