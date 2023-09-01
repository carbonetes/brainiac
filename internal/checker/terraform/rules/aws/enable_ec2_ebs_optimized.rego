# METADATA
# title: "Verify that EC2 is EBS optimized"
# description: "By enabling EBS optimization for EC2 instances, the performance of EBS storage volumes can be significantly enhanced, resulting in improved I/O throughput and reduced latency for applications with high disk I/O requirements."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance#ebs_optimized
# custom:
#   id: CB_TFAWS_121
#   severity: LOW
package lib.terraform.CB_TFAWS_121

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_instance"
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
    isvalid(resource)
    resource.Attributes.ebs_optimized == true
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "'aws_instance' for 'ebs_optimized' is set properly.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_instance' for 'ebs_optimized' should be set.",
                "snippet": block }
} 