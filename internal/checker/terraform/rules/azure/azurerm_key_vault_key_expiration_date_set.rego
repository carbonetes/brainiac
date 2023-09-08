# METADATA
# title: "Confirm that an expiration date has been specified for all keys"
# description: "Please verify that expiration dates have been assigned to all keys in the system. This practice enhances security by automatically invalidating keys after a designated period, mitigating the risk associated with prolonged access to sensitive resources."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_key.html
# custom:
#   id: CB_TFAZR_010
#   severity: CRITICAL
package lib.terraform.CB_TFAZR_010


isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "azurerm_key_vault_key"
}

resource[resource] {
    block := pass[_]
	resource := concat(".", block.Labels)
} 

resource[resource] { 
    block := fail[_]
	resource := concat(".", block.Labels)
} 

pass[resource]{
    resource := input[_]
	isvalid(resource)
    resource.Attributes.expiration_date != ""
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "An expiration date has been specified for all keys",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "An expiration date must be specified for all keys",
                "snippet": block }
} 