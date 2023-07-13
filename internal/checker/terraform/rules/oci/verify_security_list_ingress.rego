# METADATA
# title: "Verify that VCN has an inbound security list"
# description: "By using Terraform to define and provision resources such as a VCN with an inbound security list, it is easier to ensure consistent and reproducible infrastructure deployments, leading to improved infrastructure management and reduced chances of misconfigurations or security vulnerabilities."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_security_list#ingress_security_rules
# custom:
#   id: CB_TFOCI_016
#   severity: HIGH
package lib.terraform.CB_TFOCI_016

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "oci_core_security_list"
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

    resource.Blocks[_].Type == "ingress_security_rules"
    has_attribute(resource.Blocks[_].Attributes, "protocol")
    resource.Blocks[_].Attributes.protocol != ""
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}



passed[result] {
	block := pass[_]
	result := { "message": "'oci_file_storage_file_system' for 'ingress_security_rules' is set properly.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "'oci_file_storage_file_system' for 'ingress_security_rules' should be set.",
                "snippet": block }
} 