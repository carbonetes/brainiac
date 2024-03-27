# METADATA
# title: "Verify that audit logs are enabled for DocDB"
# description: "Effectively monitor and track activity within your Amazon DocumentDB (DocDB) cluster by enabling audit logs. This essential feature enhances security and compliance measures, providing valuable insights into your DocDB environment. Stay informed about cluster operations with ease."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/docdb_cluster_parameter_group
# custom:
#   id: CB_TFAWS_073
#   severity: LOW
package lib.terraform.CB_TFAWS_073

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_docdb_cluster_parameter_group"
}

resource contains resource if {
	some block in pass
	resource := concat(".", block.Labels)
}

resource contains resource if {
	some block in fail
	resource := concat(".", block.Labels)
}

pass contains resource if {
	some resource in input
	isvalid(resource)
	some parameter in resource.Blocks
	parameter.Type == "parameter"
	parameter.Attributes.name == "audit_logs"
	parameter.Attributes.value == "enabled"
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "Audit logs are active in DocDB.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Audit logs should be active in DocDB.",
		"snippet": block,
	}
}