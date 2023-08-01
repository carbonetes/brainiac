# METADATA
# title: "Verify SageMaker notebook instances should be launched into a custom VPC"
# description: "Verifying that SageMaker notebook instances are launched into a custom VPC enhances security, control, and network isolation, allowing granular access control, compliance adherence, data privacy, and resource optimization for machine learning workflows in Amazon SageMaker."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution.html
# custom:
#   id: CB_TFAWS_288
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_288

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_sagemaker_notebook_instance"
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
    resource.Attributes.subnet_id != ""
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "SageMaker notebook instances launched into a custom VPC",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_sagemaker_notebook_instance' subnet_id must be set.",
                "snippet": block }
}
