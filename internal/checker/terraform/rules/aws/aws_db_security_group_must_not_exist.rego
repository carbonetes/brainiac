# METADATA
# title: "Verify there are no resources named RDS Security Groups"
# description: "RDS Security Groups are only to be used when dealing with an RDS instance outside of a VPC, hence this resource shouldn't exist."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/figma/aws-4-49-0/latest/docs/resources/db_security_group
# custom:
#   id: CB_TFAWS_189
#   severity: LOW
package lib.terraform.CB_TFAWS_189
import rego.v1

isvalid(block) if {
	block.Type == "resource"
    "aws_db_security_group" in block.Labels
}

resource contains resource if {
	some block in fail
	resource := concat(".", block.Labels)
}

fail contains resource if {
	some resource in input
	isvalid(resource)
}

passed := []

failed contains result if {
	some block in fail
	result := { "message": "'RDS Security Groups' does not exist.",
                "snippet": block }
}
