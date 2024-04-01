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
import rego.v1

isvalid(block) if{
	block.Type == "resource"
    some label in block.Labels 
    supported_resource := ["aws_db_instance", "aws_rds_cluster_instance"]
    label in supported_resource
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
    resource.Attributes.auto_minor_version_upgrade == true
}

fail contains block if {
	some block in input
	isvalid(block)
   	not pass[block]
}

passed contains result if {
    some block in pass
	result := { "message": "'aws_db_instance' or 'aws_rds_cluster_instance' for 'auto_minor_version_upgrade' is set properly.",
                "snippet": block}
}

failed contains result if {
    some block in fail
	result := { "message": "'aws_db_instance' or 'aws_rds_cluster_instance' for 'auto_minor_version_upgrade' should be set.",
                "snippet": block}
}


