# METADATA
# title: "Verify DMS instance gets all minor upgrade automatically"
# description: " By enabling automatic minor upgrades, you can leverage the latest features and improvements introduced by the DMS service without manual intervention or downtime."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dms_replication_instance#auto_minor_version_upgrade
# custom:
#   id: CB_TFAWS_213
#   severity: LOW
package lib.terraform.CB_TFAWS_213
import rego.v1

isvalid(block) if{
	block.Type == "resource"
    some label in block.Labels 
    label == "aws_dms_replication_instance"
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
	result := { "message": "DMS instance gets all minor upgrade automatically",
                "snippet": block }
}

failed contains result if {
    some block in fail
	result := { "message": "'aws_dms_replication_instance' auto_minor_version_upgrade must be set to true",
                "snippet": block }
} 