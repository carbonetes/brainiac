# METADATA
# title: "Verify that IAM authentication is enabled for the RDS cluster"
# description: "When users and applications connect to your RDS database, IAM authentication is used to verify their identities through AWS Identity and Access Management (IAM). As you can use IAM policies and multi-factor authentication to govern access to your database, this can be more secure than conventional password-based authentication."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/4.1.0/docs/data-sources/rds_cluster
# custom:
#   id: CB_TFAWS_153
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_153
import rego.v1

isvalid(block) if{
	block.Type == "resource"
    some label in block.Labels 
    label == "aws_rds_cluster"
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
    has_attribute(resource.Attributes, "iam_database_authentication_enabled")
    resource.Attributes.iam_database_authentication_enabled == true
}


fail contains block if {
	some block in input
	isvalid(block)
   	not pass[block]
}

passed contains result if {
    some block in pass
	result := { "message": "'aws_rds_cluster' IAM authentication is enabled.",
                "snippet": block }
}

failed contains result if {
    some block in fail
	result := { "message": "'aws_rds_cluster' IAM authentication must be enabled.",
                "snippet": block }
} 