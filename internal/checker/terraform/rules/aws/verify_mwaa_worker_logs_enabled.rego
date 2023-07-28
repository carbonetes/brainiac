# METADATA
# title: "Verify that MWAA environment has worker logs enabled"
# description: "By enabling worker logs in the Amazon Managed Workflows for Apache Airflow (MWAA) environment using Terraform, it is important to gain valuable insights and troubleshoot potential issues, ensuring better monitoring and management of the workflow execution."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/mwaa_environment#logging_configuration
# custom:
#   id: CB_TFAWS_271
#   severity: LOW
package lib.terraform.CB_TFAWS_271

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_mwaa_environment"
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
    resource.Blocks[_].Blocks[_].Type == "worker_logs"
    resource.Blocks[_].Blocks[_].Attributes.enabled == true
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "MWAA environment has worker logs enabled.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "MWAA environment does not have worker logs enabled.",
                "snippet": block }
} 