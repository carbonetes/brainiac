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
import rego.v1

isvalid(block) if{
	block.Type == "resource"
    some label in block.Labels 
    label == "aws_qldb_ledger"
}

resource contains resource if {
    some block in pass
	resource := concat(".", block.Labels)
} 

resource contains resource if{
	some block in fail
	resource := concat(".", block.Labels)
} 

fail contains resource if {
    some resource in input
	isvalid(resource)
    resource.Attributes.deletion_protection == false
}

pass contains block if {
	some block in input
	isvalid(block)
   	not fail[block]
}

passed contains result if {
    some block in pass
	result := { "message": "Deletion protection in QLDB ledger is activated.",
                "snippet": block }
}

failed contains result if {
    some block in fail
	result := { "message": "Deletion protection in QLDB ledger must be activated.",
                "snippet": block }
} 