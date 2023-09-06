# METADATA
# title: "Verify Azure Instance does not use basic authentication(Use SSH Key Instead)"
# description: "By avoiding basic authentication, the risk of unauthorized access to Azure instances is significantly reduced, enhancing overall system security.."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine?c=coisadenerd?c=coisadenerd#disable_password_authentication
# custom:
#   id: CB_TFAZR_001
#   severity: HIGH
package lib.terraform.CB_TFAZR_001

supportedResources := ["azurerm_virtual_machine", "azurerm_linux_virtual_machine"]
isvalid(block){
	block.Type == "resource"
    block.Labels[_] == supportedResources[_]
}

resource[resource] {
    block := pass[_]
	resource := concat(".", block.Labels)
} 

resource[resource] { 
    block := fail[_]
	resource := concat(".", block.Labels)
} 

fail[resource]{
    resource := input[_]
	isvalid(resource)
    block := resource.Blocks[_]
    block.Type == "os_profile_linux_config"
    block.Attributes.disable_password_authentication == false
}

pass[block] {
    block := input[_]
	isvalid(block)
   	not fail[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "Azure Instance does not use basic authentication.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "Azure Instance 'os_profile_linux_config' disable_password_authentication should not be set false",
                "snippet": block }
} 