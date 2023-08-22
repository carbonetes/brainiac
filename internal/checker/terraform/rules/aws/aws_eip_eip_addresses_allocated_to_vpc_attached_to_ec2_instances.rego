# METADATA
# title: "An EIP addresses of a VPC must be connected to EC2 instances"
# description: "In order to build NAT gateways in your AWS account, verify that an Elastic IP (EIP) has been assigned for each one. "
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip
# custom:
#   id: CB_TFAWS_352
#   severity: LOW
package lib.terraform.CB_TFAWS_352

import future.keywords.if

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_eip"
}

resource[resource] {
    block := pass[_]
	resource := concat(".", block.Labels)
} 

resource[resource] { 
    block := fail[_]
	resource := concat(".", block.Labels)
} 

getTheLabelForAwsInstance[label]{
    resource := input[_]
    resource.Type == "resource"
    resource.Labels[_] == "aws_instance"
    label := concat(".", resource.Labels)
}

isValidAttachments{
    resource := input[_]
    resource.Type == "resource"
    resource.Labels[_] == "aws_eip"
    resource.Attributes.vpc == true
    contains(resource.Attributes.instance, getTheLabelForAwsInstance[_])
}
 
pass[resource]{
    resource := input[_]
    isvalid(resource)
    isValidAttachments
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "An EIP addresses of a VPC is connected to EC2 instances.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "An EIP addresses of a VPC must be connected to EC2 instances.",
                "snippet": block }
} 