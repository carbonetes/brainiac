# METADATA
# title: "Verify that Elasticsearch is configured inside a VPC"
# description: "By enabling cross-zone load balancing for an Elastic Load Balancer (ELB), traffic is evenly distributed across instances in different availability zones, ensuring high availability and optimal resource utilization."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/3.3.0/docs/resources/elb#cross_zone_load_balancing
# custom:
#   id: CB_TFAWS_141
#   severity: LOW
package lib.terraform.CB_TFAWS_141

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_elb"
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

pass[resource] {
	resource := input[_]
    isvalid(resource)
    not has_attribute(resource.Attributes, "cross_zone_load_balancing")
}

pass[resource] {
	resource := input[_]
    isvalid(resource)
    resource.Attributes.cross_zone_load_balancing == true
}

block_check(block, key) := result {
    block.Type == key
    result := block
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "'aws_elb' for 'cross_zone_load_balancing' is set properly.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_elb' for 'cross_zone_load_balancing' should be set.",
                "snippet": block }
} 