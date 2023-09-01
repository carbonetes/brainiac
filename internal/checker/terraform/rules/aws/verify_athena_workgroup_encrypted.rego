# METADATA
# title: "Verify that Athena Workgroup is encrypted"
# description: "By enabling encryption for Athena Workgroup, data at rest and in transit is encrypted, providing an additional layer of security."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/3.17.0/docs/resources/athena_workgroup
# custom:
#   id: CB_TFAWS_137
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_137

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

has_attribute(key, value) {
  _ = key[value]
}

pass[resource]{
    resource := input[_]
	isvalid(resource)
    resource.Blocks[_].Type == "configuration"
    resource.Blocks[_].Blocks[_].Type == "result_configuration"
    resource.Blocks[_].Blocks[_].Blocks[_].Type == "encryption_configuration"
    has_attribute(resource.Blocks[_].Blocks[_].Blocks[_].Attributes, "encryption_option")
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "'aws_athena_workgroup' encryption is set properly.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_athena_workgroup' should be encrypted",
                "snippet": block }
} 