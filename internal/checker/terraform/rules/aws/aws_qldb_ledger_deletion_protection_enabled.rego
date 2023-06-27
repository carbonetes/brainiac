# METADATA
# title: "Verify that deletion protection is activated in QLDB ledger"
# description: "The data's accessibility may be impacted if deletion protection for AWS QLDB Ledger is not enabled."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/qldb_ledger.html
# custom:
#   id: CB_TFAWS_162
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_162

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_qldb_ledger"
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

fail[resource]{
    resource := input[_]
	isvalid(resource)
    resource.Attributes.deletion_protection == false
}

passed[result] {
	block := pass[_]
	result := { "message": "Deletion protection in QLDB ledger is activated.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "Deletion protection in QLDB ledger must be activated.",
                "snippet": block }
} 