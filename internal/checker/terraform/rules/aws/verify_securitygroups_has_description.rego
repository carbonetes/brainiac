# METADATA
# title: "Verify every security groups rule has a description"
# description: "This can help in auditing and compliance efforts, as well as making it easier for administrators to understand and manage the security group configuration."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group.html
# custom:
#   id: CB_TFAWS_043
#   severity: LOW
package lib.terraform.CB_TFAWS_043


supportedResource := [
        "aws_db_security_group", 
        "aws_elasticache_security_group", 
        "aws_redshift_security_group", 
        "aws_security_group", 
        "aws_security_group_rule", 
        "aws_vpc_security_group_egress_rule", 
        "aws_vpc_security_group_ingress_rule"]

validGroups := ["ingress", "egress"]

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == supportedResource[_]
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
    has_attribute(resource.Attributes, "description")
}

fail[block] {
    block := pass[_]
    childBlock := block.Blocks[_]
    childBlock.Type == validGroups[_]
    not has_attribute(childBlock.Attributes, "description")
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "security groups rule has a description.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "security groups rule should have a description.",
                "snippet": block }
} 