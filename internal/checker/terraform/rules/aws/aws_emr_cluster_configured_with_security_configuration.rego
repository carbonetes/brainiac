# METADATA
# title: "Guarantee proper configuration of a security setup for AWS EMR clusters"
# description: "Enhance security protocols by enforcing the setup of a dedicated security configuration within AWS EMR clusters, bolstering data protection and access control measures."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/emr_cluster
# custom:
#   id: CB_TFAWS_365
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_365

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_emr_cluster"
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
    has_attribute(resource.Attributes, "security_configuration")
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "Security setup for AWS EMR clusters is properly configured.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "Security setup for AWS EMR clusters must be properly configured.",
                "snippet": block }
} 