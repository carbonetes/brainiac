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
    resource.Attributes.deletion_protection == true
}

fail contains block if {
	some block in input
	isvalid(block)
   	not pass[block]
}

passed contains result if {
    some block in pass
	result := { "message": "'aws_rds_cluster' for 'deletion_protection' is set properly.",
                "snippet": block }
}

failed contains result if {
    some block in fail
	result := { "message": "'aws_rds_cluster' for 'deletion_protection' should be set.",
                "snippet": block }
} 