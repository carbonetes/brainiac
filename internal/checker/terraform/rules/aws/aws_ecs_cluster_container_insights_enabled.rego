# METADATA
# title: "Check that the ECS cluster's container insights are enabled"
# description: "Metrics and logs generated by containerized apps and microservices can be gathered, compiled, and summarized using Container Insights."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_cluster
# custom:
#   id: CB_TFAWS_060
#   severity: LOW
package lib.terraform.CB_TFAWS_060

supportedResource := ["aws_ecs_cluster"]

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == supportedResource[_]
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
    setting := resource.Blocks[_]
    setting.Type == "setting"
    setting.Attributes.name == "containerInsights"
    setting.Attributes.value == "enabled"
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "aws_ecs_cluster container insights are enabled.",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "aws_ecs_cluster container insights should be enabled.",
                "snippet": block}
}
