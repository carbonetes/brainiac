# METADATA
# title: "Verify that EC2 instance should not have public IP"
# description: "By not assigning a public IP to the EC2 instance, we ensure that its resources are not directly accessible from the internet, enhancing security and reducing the risk of unauthorized access."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance#associate_public_ip_address
# custom:
#   id: CB_TFAWS_095
#   severity: HIGH
package lib.terraform.CB_TFAWS_095

import future.keywords.if

supportedResources := ["aws_instance", "aws_launch_template"]

isvalid(block, resource){
	block.Type == "resource"
    block.Labels[_] == resource
}


resource[resource] {
    block := pass[_]
	resource := concat(".", block.Labels)
} 

resource[resource] { 
    block := fail[_]
	resource := concat(".", block.Labels)
} 

pass[resource] {
	resource := input[_]
    isvalid(resource, "aws_instance")
    has_associate_public_ip_address(resource.Attributes, "associate_public_ip_address")
}

pass[resource] {
	resource := input[_]
    isvalid(resource, "aws_launch_template")
    has_network_interfaces(resource.Blocks)
}

has_network_interfaces(blocks) := result if {
    blocks[_].Type == "network_interfaces"
    result := has_associate_public_ip_address(blocks[_].Attributes, "associate_public_ip_address")
} else := result if {
    result := true
}

has_associate_public_ip_address(key, value) := result if {
    key[value] == false
    result := true
} else := result if {
    key[value] == true
    result := false
} else := result if {
  result := true
}

fail[block] {
    block := input[_]
	isvalid(block, supportedResources[_])
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "'aws_instance' or 'aws_launch_template' for 'associate_public_ip_address' is set properly.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_instance' or 'aws_launch_template' for 'associate_public_ip_address' should be set.",
                "snippet": block }
} 