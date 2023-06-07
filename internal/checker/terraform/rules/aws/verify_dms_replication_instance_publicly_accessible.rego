# METADATA
# title: "Verify that DMS replication instance should not be publicly accessible"
# description: "By not allowing public accessibility to the DMS replication instance, the security and integrity of the database are safeguarded from unauthorized access or potential security breaches."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dms_replication_instance#publicly_accessible
# custom:
#   id: CB_TFAWS_096
#   severity: HIGH
package lib.terraform.CB_TFAWS_096

import future.keywords.if

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_dms_replication_instance"
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

pass[block] {
    block := input[_]
	isvalid(block)
   	not fail[block]
}

fail[resource] {
	resource := input[_]
    isvalid(resource)
    has_attribute(resource.Attributes, "publicly_accessible")
    resource.Attributes.publicly_accessible == true
}

passed[result] {
	block := pass[_]
	result := { "message": "'aws_dms_replication_instance' for 'publicly_accessible' is set properly.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_dms_replication_instance' for 'publicly_accessible' should be set.",
                "snippet": block }
} 