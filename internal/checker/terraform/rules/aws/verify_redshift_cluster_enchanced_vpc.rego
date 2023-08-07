# METADATA
# title: "Verify that Redshift clusters use enhanced VPC routing"
# description: "By enabling enhanced VPC routing for Redshift clusters, network traffic is efficiently routed through the VPC, ensuring secure and optimized communication between the cluster and other resources within the VPC."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/redshift_cluster
# custom:
#   id: CB_TFAWS_309
#   severity: LOW
package lib.terraform.CB_TFAWS_309

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_redshift_cluster"
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
	resource.Attributes.enhanced_vpc_routing == true
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "Redshift clusters use enhanced VPC routing.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "Redshift clusters should use enhanced VPC routing.",
                "snippet": block }
} 