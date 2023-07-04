# METADATA
# title: "Verify that OCI File System is Encrypted with a customer Managed Key"
# description: "By encrypting the OCI File System with a customer-managed key, sensitive data stored within the file system is protected from unauthorized access, ensuring data confidentiality and compliance with security standards."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/file_storage_file_system#kms_key_id
# custom:
#   id: CB_TFOCI_003
#   severity: HIGH
package lib.terraform.CB_TFOCI_003

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "oci_file_storage_file_system"
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

    has_attribute(resource.Attributes, "kms_key_id")
    resource.Attributes.kms_key_id != ""
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}



passed[result] {
	block := pass[_]
	result := { "message": "'oci_file_storage_file_system' for 'kms_key_id' is set properly.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "'oci_file_storage_file_system' for 'kms_key_id' should be set.",
                "snippet": block }
} 