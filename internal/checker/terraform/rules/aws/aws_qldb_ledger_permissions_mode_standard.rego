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
import rego.v1

isvalid(block) if{
	block.Type == "resource"
    some label in block.Labels 
    label == "aws_qldb_ledger"
}

has_attribute(key, value) if {
    value in object.keys(key)
}

resource contains resource if {
    some block in pass
	resource := concat(".", block.Labels)
} 

resource contains resource if{
	some block in fail
	resource := concat(".", block.Labels)
} 

pass contains resource if {
    some resource in input
	isvalid(resource)
    has_attribute(resource.Attributes, "permissions_mode")
    resource.Attributes.permissions_mode == "STANDARD"
}

fail contains block if {
	some block in input
	isvalid(block)
   	not pass[block]
}

passed contains result if {
    some block in pass
	result := { "message": "QLDB ledger permissions mode is set to STANDARD.",
                "snippet": block }
}

failed contains result if {
    some block in fail
	result := { "message": "QLDB ledger permissions mode must be set to STANDARD.",
                "snippet": block }
} 