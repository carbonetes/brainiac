# METADATA
# title: "Make certain that Neptune logging is activated"
# description: "Setting your cluster up to opportunistically export its logs to AWS Cloudwatch is advised."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/neptune_cluster
# custom:
#   id: CB_TFAWS_070
#   severity: HIGH
package lib.terraform.CB_TFAWS_070

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_neptune_cluster"
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
    resource.Attributes.enable_cloudwatch_logs_exports[_] == "audit"
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "Neptune logging is active.",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "Neptune logging should be active",
                "snippet": block }
}
