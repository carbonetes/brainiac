# METADATA
# title: "Make certain cross-zone load balancing is enabled in the load balancer (network/gateway)"
# description: "With the use of a feature called cross-zone load balancing, all activated availability zones' healthy targets receive an equal share of the incoming traffic. This can guarantee that your application can manage more traffic, lower the possibility of any availability zone getting overwhelmed, and may affect the performance of your load balancer."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/3.61.0/docs/data-sources/lb
# custom:
#   id: CB_TFAWS_132
#   severity: LOW
package lib.terraform.CB_TFAWS_132
import rego.v1

isvalid(block) if{
	block.Type == "resource"
    some label in block.Labels 
    supported_resource := ["aws_alb", "aws_lb"]
    label in supported_resource
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

pass contains resource if{
    some resource in input
	isvalid(resource)
    has_attribute(resource.Attributes, "enable_cross_zone_load_balancing")
    resource.Attributes.enable_cross_zone_load_balancing == true
}

fail contains block if {
    some block in input
	isvalid(block)
   	not pass[block]
}

passed contains result if {
    some block in pass
	result := { "message": "'aws_alb', 'aws_lb' cross-zone load balancing is active.",
                "snippet": block}
}

failed contains result if {
    some block in fail
	result := { "message": "'aws_alb', 'aws_lb' cross-zone load balancing is active.",
                "snippet": block }
}
