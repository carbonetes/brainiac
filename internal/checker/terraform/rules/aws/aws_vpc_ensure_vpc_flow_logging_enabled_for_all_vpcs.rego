# METADATA
# title: "Verify that VPC flow logging is activated in every VPC"
# description: "We recommend that VPC Flow Logs are enabled for packet Rejects for VPCs to help detect anomalous traffic and insight during security workflows."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc.html
# custom:
#   id: CB_TFAWS_340
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_340

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_vpc"
}

resource[resource] {
    block := pass[_]
	resource := concat(".", block.Labels)
} 

resource[resource] { 
    block := fail[_]
	resource := concat(".", block.Labels)
} 

getTheLabelforAwsVpc[label]{
    resource := input[_]
    resource.Type == "resource"
    resource.Labels[_] == "aws_vpc"
    label := concat(".", resource.Labels)
}

isValidResourceAttached{
    resource := input[_]
    resource.Type == "resource"
    resource.Labels[_] == "aws_flow_log"
    label := getTheLabelforAwsVpc[_]
    contains(resource.Attributes.vpc_id, label)
}

pass[resource]{
    resource := input[_]
    isvalid(resource)
    isValidResourceAttached
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "The VPC flow logging is activated in every VPC.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "The VPC flow logging must be activated in every VPC.",
                "snippet": block }
} 