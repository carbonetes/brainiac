# METADATA
# title: "Verify that File Storage File System access is restricted to root users"
# description: "By restricting File Storage File System access to root users only and configuring properties such as identity squashing, anonymous GID, and anonymous UID, organizations can enhance security by ensuring that only privileged users have access and preventing unauthorized or anonymous users from accessing sensitive file data."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/file_storage_export#export_options
# custom:
#   id: CB_TFOCI_026
#   severity: HIGH
package lib.terraform.CB_TFOCI_026
import future.keywords.if

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "oci_file_storage_export"
}

has_attribute(key, value) {
  _ = key[value]
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
    count(resource.Blocks) == 0
}

pass[resource] {
	resource := input[_]
    isvalid(resource)
    block := resource.Blocks[_]
    block.Type != "export_options"
}

pass[resource] {
	resource := input[_]
    isvalid(resource)
    block := resource.Blocks[_]
    block.Type == "export_options"
    not has_attribute(block.Attributes, "identity_squash")
}

pass[resource] {
	resource := input[_]
    isvalid(resource)
    resource.Blocks[_].Type == "export_options"
    identity_check(resource.Blocks[_].Attributes)
}

identity_check(attributes) := result if {
    lower(attributes.identity_squash) == "root"
    to_number(attributes.anonymous_gid) == 65534
    to_number(attributes.anonymous_uid) == 65534
    result := true
} else := result if {
    lower(attributes.identity_squash) != "root"
    result := true
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "'oci_file_storage_export' for 'export_options' is set properly.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "'oci_file_storage_export' for 'export_options' should be set.",
                "snippet": block }
} 