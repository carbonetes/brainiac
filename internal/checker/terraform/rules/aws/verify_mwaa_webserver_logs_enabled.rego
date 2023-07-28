# METADATA
# title: "Verify that MWAA environment has webserver logs enabled"
# description: "By enabling webserver logs in the AWS Managed Apache Airflow (MWAA) environment, it becomes crucial for monitoring and troubleshooting the system, providing valuable insights into the performance and behavior of the webserver, ensuring operational efficiency and better decision-making."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/mwaa_environment#logging_configuration
# custom:
#   id: CB_TFAWS_272
#   severity: LOW
package lib.terraform.CB_TFAWS_272

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
    resource.Blocks[_].Blocks[_].Type == "webserver_logs"
    resource.Blocks[_].Blocks[_].Attributes.enabled == true
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "MWAA environment has webserver logs enabled.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "MWAA environment does not have webserver logs enabled.",
                "snippet": block }
} 