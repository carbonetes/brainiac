# METADATA
# title: "Verify that Athena Workgroup enforces configuration"
# description: "By enforcing encryption in Athena Workgroups, organizations can safeguard sensitive data, enhance data security, and maintain compliance with rigorous security standards."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/athena_workgroup#enforce_workgroup_configuration
# custom:
#   id: CB_TFAWS_076
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_076

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_athena_workgroup"
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

fail[resource]{
    resource := input[_]
	isvalid(resource)
    resource.Blocks[_].Type == "configuration"
    resource.Blocks[_].Attributes.enforce_workgroup_configuration == false
}

passed[result] {
	block := pass[_]
	result := { "message": "'aws_athena_workgroup' for 'enforce_workgroup_configuration' is set properly.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_athena_workgroup' for 'enforce_workgroup_configuration' should be set.",
                "snippet": block }
} 