# METADATA
# title: "Verify that administrator users are not associated with API keys"
# description: "By removing API keys from administrator users, the configuration ensures that the administrators do not have permanent access credentials tied to their user accounts, reducing the risk of unauthorized access and potential security breaches."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/identity_api_key
# custom:
#   id: CB_TFOCI_023
#   severity: HIGH
package lib.terraform.CB_TFOCI_023
import future.keywords.if

isvalid(block){
    supportedResource := ["oci_identity_user", "oci_identity_group", "oci_identity_user_group_membership", "oci_identity_api_key"]
	block.Type == "resource"
    block.Labels[_] == supportedResource[_]
}

has_attribute(key, value) {
  _ = key[value]
}

users[resource] {
	resource := input[_]
	resource.Labels[_] == "oci_identity_user"
}

group[resource] {
	resource := input[_]
	resource.Labels[_] == "oci_identity_group"
    admin_check(resource)
}

group_membership[resource] {
	resource := input[_]
    resource.Labels[_] == "oci_identity_user_group_membership"

    resource.Attributes.user_id == concat(".",[concat(".", users[_].Labels),"id"])
    resource.Attributes.group_id == concat(".",[concat(".", group[_].Labels),"id"])
}

api_key[resource] {
	resource := input[_]
    resource.Labels[_] == "oci_identity_api_key"
    resource.Attributes.user_id == concat(".",[concat(".", users[_].Labels),"id"])
}

admin_check(resource) := true if {
	contains(lower(resource.Labels[1]), "admin")
} else := true if {
	contains(lower(resource.Attributes.name), "admin")
}

resource[resource] {
    block := pass[_]
	resource := concat(".", block.Labels)
}

resource[resource] {
    block := fail[_]
	resource := concat(".", block.Labels)
}

pass[block] {
    block := input[_]
	isvalid(block)
   	not fail[block]
}

fail[resource] {
    some index, i
    api_key[_].Attributes.user_id == group_membership[_].Attributes.user_id
    api_users := split(api_key[_].Attributes.user_id, ".")[_]
    api_users != "oci_identity_user"
    api_users != "id"
    users[index].Labels[_] == api_users
    input[i] == users[index]
    resource := input[i]
}


passed[result] {
    pass[_]
	result := { "message": "No Administrator user associated with API keys was found.",
                "snippet": {} }
}

failed[result] {
    block := fail[_]
	result := { "message": "An Administrator user associated with API keys was found.",
                "snippet": block }
}