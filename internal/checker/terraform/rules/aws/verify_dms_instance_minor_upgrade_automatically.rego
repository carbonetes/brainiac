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

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_dms_replication_instance"
}

resource[resource] {
    block := pass[_]
	resource := concat(".", block.Labels)
} 

resource[resource] { 
    block := fail[_]
	resource := concat(".", block.Labels)
} 

pass[blocks]{
    blocks := input[_]
	isvalid(blocks)
    blocks.Attributes.auto_minor_version_upgrade == true
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "DMS instance gets all minor upgrade automatically",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_dms_replication_instance' auto_minor_version_upgrade must be set to true",
                "snippet": block }
} 