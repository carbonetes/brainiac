# METADATA
# title: "Verify that DB instance gets all minor upgrades automatically"
# description: "By enabling automatic minor version upgrades for the database instance through the auto_minor_version_upgrade property, the Terraform configuration ensures that the database receives timely updates and patches, thus enhancing security, stability, and performance without manual intervention."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance#auto_minor_version_upgrade
# custom:
#   id: CB_TFAWS_198
#   severity: LOW
package lib.terraform.CB_TFAWS_198

import future.keywords.in 

supportedResource := ["aws_db_instance", "aws_rds_cluster_instance"]

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == supportedResource[_]
}

resource [resource]{
    block := pass[_]
	resource := concat(".", block.Labels)
} 
resource [resource]{
    block := fail[_]
	resource := concat(".", block.Labels)
} 

pass[resource] {
    resource := input[_]
    isvalid(resource)
    resource.Attributes.auto_minor_version_upgrade == true
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "'aws_db_instance' or 'aws_rds_cluster_instance' for 'auto_minor_version_upgrade' is set properly.",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_db_instance' or 'aws_rds_cluster_instance' for 'auto_minor_version_upgrade' should be set.",
                "snippet": block}
}


