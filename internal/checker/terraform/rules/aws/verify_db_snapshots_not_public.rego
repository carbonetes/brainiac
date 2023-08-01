# METADATA
# title: "Verify DB Snapshots are not Public"
# description: "Verifying that DB snapshots are not public ensures data protection, compliance, cost optimization, prevention of data leaks, data recovery control, and data integrity."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_snapshot#shared_accounts
# custom:
#   id: CB_TFAWS_280
#   severity: HIGH
package lib.terraform.CB_TFAWS_280

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_db_snapshot"
}

resource [resource]{
    block := pass[_]
	resource := concat(".", block.Labels)
} 
resource [resource]{
    block := fail[_]
	resource := concat(".", block.Labels)
} 

fail[resource]{
    resource := input[_]
	isvalid(resource)
    resource.Attributes.shared_accounts == "all"
}

fail[resource]{
    resource := input[_]
	isvalid(resource)
    test := resource.Attributes.shared_accounts[_]
    test == "all"
}


pass[block] {
    block := input[_]
	isvalid(block)
   	not fail[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "'aws_db_snapshot' shared_accounts is set properly.",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "aws_db_snapshot' shared_accounts should not be set to 'all'.",
                "snippet": block }
}
