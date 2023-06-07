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

import future.keywords.in 



isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_docdb_cluster_parameter_group"
}

resource [resource]{
    block := pass[_]
	resource := concat(".", block.Labels)
} 
resource [resource]{
    block := fail[_]
	resource := concat(".", block.Labels)
} 

pass[resource]{
    resource := input[_]
	isvalid(resource)
    parameter := resource.Blocks[_]
    parameter.Type == "parameter"
    parameter.Attributes.name == "audit_logs"
    parameter.Attributes.value == "enabled"
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "Audit logs are active in DocDB.",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "Audit logs should be active in DocDB.",
                "snippet": block}
}
