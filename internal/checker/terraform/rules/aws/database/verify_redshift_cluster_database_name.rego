# METADATA
# title: "Verify that Redshift clusters do not use the default database name"
# description: "By specifying a custom database name for Redshift clusters, it is important to ensure better organization, security, and clarity in data management, especially in multi-cluster environments."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/redshift_cluster
# custom:
#   id: CB_TFAWS_308
#   severity: LOW
package lib.terraform.CB_TFAWS_308

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_redshift_cluster"
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
	resource.Attributes.database_name != ""
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "Redshift clusters does not use the default database name.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "Redshift clusters must not use the default database name.",
                "snippet": block }
} 