# METADATA
# title: "Verify that EC2 Auto Scaling groups use EC2 launch templates"
# description: "By utilizing an EC2 launch template for Auto Scaling groups in Terraform, you can ensure consistent and efficient deployment of instances, simplifying maintenance and enhancing scalability in AWS infrastructure management."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group
# custom:
#   id: CB_TFAWS_297
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_297

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_autoscaling_group"
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
    resource.Blocks[_].Type == "launch_template"
}

fail[resource] {
    resource := input[_]
    isvalid(resource)
    not pass[resource]
}

passed[result] {
	block := pass[_]
	result := { "message": "EC2 Auto Scaling groups is using EC2 launch templates.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "EC2 Auto Scaling groups should use EC2 launch templates.",
                "snippet": block }
} 