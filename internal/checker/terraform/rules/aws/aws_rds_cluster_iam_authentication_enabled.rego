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

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_rds_cluster"
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
    has_attribute(resource.Attributes, "iam_database_authentication_enabled")
    resource.Attributes.iam_database_authentication_enabled == true
}


fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "'aws_rds_cluster' IAM authentication is enabled.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_rds_cluster' IAM authentication must be enabled.",
                "snippet": block }
} 