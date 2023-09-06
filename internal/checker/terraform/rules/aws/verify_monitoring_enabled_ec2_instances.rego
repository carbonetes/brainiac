# METADATA
# title: "Verify that detailed monitoring is enabled for EC2 instances"
# description: "With detailed monitoring, you can accurately monitor resource utilization, identify performance bottlenecks, and make informed decisions for scaling and optimizing your EC2 infrastructure."
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance#monitoring
# custom:
#   id: CB_TFAWS_123
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_123

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_instance"
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
   resource.Attributes.monitoring == true
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "'aws_instance' monitoring is enabled",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_instance' 'monitoring' should be set to true",
                "snippet": block}
}
