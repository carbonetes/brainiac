# METADATA
# title: "Make certain that the security groups for Amazon EMR clusters are closed to the world"
# description: "Making guaranteed that the security groups for your Amazon EMR clusters are not accessible to the world is normally a wise security move. As outside parties won't be able to connect to them via the internet, this can aid in protecting your EMR clusters from unwanted access."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/figma/aws-4-49-0/latest/docs/resources/emr_cluster
# custom:
#   id: CB_TFAWS_329
#   severity: LOW
package lib.terraform.CB_TFAWS_329

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_emr_cluster"
}

resource[resource] {
    block := pass[_]
	resource := concat(".", block.Labels)
} 

resource[resource] { 
    block := fail[_]
	resource := concat(".", block.Labels)
} 

isValidResourceAttached{
    resource := input[_]
    resource.Type == "resource"
    resource.Labels[_] == "aws_security_group"
    resource.Blocks[_].Type == "ingress"
    resource.Blocks[_].Attributes.cidr_blocks[_] == "0.0.0.0/0"
}

fail[resource]{
    resource := input[_]
    isvalid(resource)
    isValidResourceAttached
}

pass[block] {
    block := input[_]
	isvalid(block)
   	not fail[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "The security groups for Amazon EMR clusters are closed to the world.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "The security groups for Amazon EMR clusters must not be open to the world.",
                "snippet": block }
} 