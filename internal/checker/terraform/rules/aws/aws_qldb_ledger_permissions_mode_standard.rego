# METADATA
# title: "Make certain that the QLDB ledger permissions mode is set to STANDARD"
# description: "A completely operated ledger database for cryptographically proven transaction recording is called Amazon Quantum Ledger Database (Amazon QLDB). You may list all the ledgers in your account, retrieve information about a single ledger, create, update, and delete ledgers in Amazon QLDB using the QLDB API or the AWS Command Line Interface (AWS CLI)."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/qldb_ledger.html
# custom:
#   id: CB_TFAWS_161
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_161

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_qldb_ledger"
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

pass[resource]{
    resource := input[_]
	isvalid(resource)
    has_attribute(resource.Attributes, "permissions_mode")
    resource.Attributes.permissions_mode == "STANDARD"
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "QLDB ledger permissions mode is set to STANDARD.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "QLDB ledger permissions mode must be set to STANDARD.",
                "snippet": block }
} 