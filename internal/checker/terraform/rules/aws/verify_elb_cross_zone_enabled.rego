# METADATA
# title: "Verify that ELB is cross-zone-load-balancing enabled"
# description: "By enabling cross-zone load balancing for an Elastic Load Balancer (ELB), traffic is evenly distributed across instances in different availability zones, ensuring high availability and optimal resource utilization."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/3.3.0/docs/resources/elb#cross_zone_load_balancing
# custom:
#   id: CB_TFAWS_141
#   severity: LOW
package lib.terraform.CB_TFAWS_141
import rego.v1

isvalid(block) if{
	block.Type == "resource"
    some label in block.Labels 
    label == "aws_elb"
}

has_attribute(key, value) if {
    value in object.keys(key)
}

resource contains resource if {
    some block in pass
	resource := concat(".", block.Labels)
} 

resource contains resource if{
	some block in fail
	resource := concat(".", block.Labels)
}  

pass contains resource if {
    some resource in input
    isvalid(resource)
    not has_attribute(resource.Attributes, "cross_zone_load_balancing")
}

pass contains resource if {
    some resource in input
    isvalid(resource)
    resource.Attributes.cross_zone_load_balancing == true
}

fail contains block if {
	some block in input
	isvalid(block)
   	not pass[block]
}

passed contains result if {
    some block in pass
	result := { "message": "'aws_elb' for 'cross_zone_load_balancing' is set properly.",
                "snippet": block }
}

failed contains result if {
    some block in fail
	result := { "message": "'aws_elb' for 'cross_zone_load_balancing' should be set.",
                "snippet": block }
} 