# METADATA
# title: "Verify all data stored in RDS is not publicly accessible"
# description: "This helps to ensure data confidentiality, integrity, and availability. "
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance#publicly_accessible
# custom:
#   id: CB_TFAWS_021
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_021

import future.keywords.in 


supportedResource := ["aws_db_instance", "aws_rds_cluster_instance"]

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == supportedResource[_]
}

resource[resource] {
    block := pass[_]
	resource := concat(".", block.Labels)
} 

resource[resource] { 
    block := fail[_]
	resource := concat(".", block.Labels)
} 

fail[resource]{
    resource := input[_]
	isvalid(resource)
    resource.Attributes.publicly_accessible == true
}

pass[block] {
    block := input[_]
	isvalid(block)
   	not fail[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "'aws_db_instance' 'publicly_accessible' is set properly.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_db_instance' 'publicly_accessible' should be set to false",
                "snippet": block }
} 