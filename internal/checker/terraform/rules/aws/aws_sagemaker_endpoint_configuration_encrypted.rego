# METADATA
# title: "Achieve secure at-rest encryption for all the data kept in the Sagemaker Endpoint"
# description: "Enabling at-rest encryption guarantees that the data on your AWS SageMaker notebook instances comply with legal standards and safeguards your SageMaker data."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sagemaker_endpoint_configuration.html
# custom:
#   id: CB_TFAWS_082
#   severity: HIGH
package lib.terraform.CB_TFAWS_082


isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_sagemaker_endpoint_configuration"
}

has_attribute(key, value) {
  _ = key[value]
}

resource [resource]{
    block := pass[_]
	resource := concat(".", block.Labels)
} 
resource [resource]{
    block := fail[_]
	resource := concat(".", block.Labels)
} 


pass[resource] {
    resource := input[_]
    isvalid(resource)
    has_attribute(resource.Attributes, "kms_key_arn")
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "Data contained in Sagemaker Endpoint is encrypted.",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "Data contained in Sagemaker Endpoint should be is encrypted.",
                "snippet": block}
}
