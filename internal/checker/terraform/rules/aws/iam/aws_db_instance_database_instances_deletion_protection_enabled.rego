# METADATA
# title: "Verify that deletion protection is activated for AWS database instances"
# description: "This check verifies that AWS database instances have deletion protection enabled, which adds an extra layer of security by preventing accidental deletions."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/fsx_ontap_file_system
# custom:
#   id: CB_TFAWS_273
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_273

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_db_instance"
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
    has_attribute(resource.Attributes, "deletion_protection")
    resource.Attributes.deletion_protection == true
}

fail[block] {
    block := input[_]
    isvalid(block)
    not pass[block]
}


passed[result] {
	block := pass[_]
	result := { "message": "Deletion protection for AWS database instances is activated.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "Deletion protection for AWS database instances must be activated.",
                "snippet": block }
} 