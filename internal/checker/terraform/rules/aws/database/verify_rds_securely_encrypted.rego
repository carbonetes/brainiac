# METADATA
# title: "Verify all data stored in the RDS is securely encrypted at rest"
# description: "Encryption of data at rest helps to prevent data breaches and protect the confidentiality, integrity, and availability of data in the RDS."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance#storage_encrypted
# custom:
#   id: CB_TFAWS_019
#   severity: HIGH
package lib.terraform.CB_TFAWS_019

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_db_instance"
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
    resource.Attributes.storage_encrypted == true
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "'aws_db_instance' 'storage_encrypted' is set properly.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_db_instance' 'storage_encrypted' should be set to true",
                "snippet": block }
} 