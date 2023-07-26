# METADATA
# title: "Verify that MWAA environment has scheduler logs enabled"
# description: "By enabling scheduler logs in an Amazon MWAA environment through Terraform, it is important to gain valuable insights into workflow execution and potential issues, facilitating efficient debugging and optimization of Apache Airflow tasks."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/mwaa_environment#logging_configuration
# custom:
#   id: CB_TFAWS_256
#   severity: LOW
package lib.terraform.CB_TFAWS_256

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_mwaa_environment"
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

pass[resource]{
    resource := input[_]
	isvalid(resource)
    resource.Blocks[_].Type == "logging_configuration"
    resource.Blocks[_].Blocks[_].Type == "scheduler_logs"
    resource.Blocks[_].Blocks[_].Attributes.enabled == true
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "MWAA environment has scheduler logs enabled.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "MWAA environment does not have scheduler logs enabled.",
                "snippet": block }
} 