# METADATA
# title: "Verify there are no resources named aws_elasticache_security_group"
# description: "This check ensures that no security groups are created for ElastiCache, which can help avoid unnecessary security group configurations and potential security risks. It is recommended to have this check pass to maintain a clean and secure infrastructure configuration."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/figma/aws-4-49-0/latest/docs/resources/elasticache_security_group
# custom:
#   id: CB_TFAWS_187
#   severity: LOW
package lib.terraform.CB_TFAWS_187

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_elasticache_security_group"
}

resource [resource]{
    block := fail[_]
	resource := concat(".", block.Labels)
} 

fail[resource]{
    resource := input[_]
	isvalid(resource)
}


passed := []

failed[result] {
    block := fail[_]
	result := { "message": "'aws_elasticache_security_group' does not exist.",
                "snippet": block }
}
