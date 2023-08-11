# METADATA
# title: "Check to see if Security Groups are linked to another resource"
# description: "You can decide which traffic is allowed to pass through your EC2 instances and which traffic is restricted by adding security groups to your ENIs or EC2 instances."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/security_group.html
# custom:
#   id: CB_TFAWS_323
#   severity: LOW
package lib.terraform.CB_TFAWS_323

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_security_group"
}

resource[resource] {
    block := pass[_]
	resource := concat(".", block.Labels)
} 

resource[resource] { 
    block := fail[_]
	resource := concat(".", block.Labels)
} 

getAwsSecurityGroupLabel[label] {
    resource := input[_]
    resource.Type == "resource"
    resource.Labels[_] == "aws_security_group"
    label := concat(".", resource.Labels)
}

validConnectedResource := ["aws_network_interface", "aws_instance"]

isValidResourceAttached{
resource := input[_]
resource.Type == "resource"
resource.Labels[_] == validConnectedResource[_]
label := getAwsSecurityGroupLabel[_]
startswith(resource.Attributes.security_groups, label)
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
	result := { "message": "Security Groups are linked to another resource.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "Security Groups must be linked to another resource.",
                "snippet": block }
} 