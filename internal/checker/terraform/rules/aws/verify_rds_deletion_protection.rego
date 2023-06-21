# METADATA
# title: "Verify that RDS clusters have deletion protection enabled"
# description: "By enabling deletion protection for RDS clusters, it ensures that critical databases are safeguarded from accidental or unauthorized deletion, providing an essential layer of protection and preserving valuable data integrity."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster_endpoint.html
# custom:
#   id: CB_TFAWS_142
#   severity: LOW
package lib.terraform.CB_TFAWS_142

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

pass[resource] {
	resource := input[_]
    isvalid(resource)
    resource.Attributes.deletion_protection == true
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "'aws_rds_cluster' for 'deletion_protection' is set properly.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_rds_cluster' for 'deletion_protection' should be set.",
                "snippet": block }
} 