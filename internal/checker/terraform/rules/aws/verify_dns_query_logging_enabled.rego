# METADATA
# title: "Verify Domain Name System (DNS) query logging is enabled for Amazon Route 53 hosted zones"
# description: "Enabling query logging enhances your monitoring and security capabilities by capturing DNS queries and responses, aiding in troubleshooting, detecting malicious activities, and providing insights into your DNS traffic."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone.html
# custom:
#   id: CB_TFAWS_349
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_349

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_route53_zone"
}

resource[resource] {
    block := pass[_]
	resource := concat(".", block.Labels)
} 

resource[resource] { 
    block := fail[_]
	resource := concat(".", block.Labels)
} 

getRouteZoneLabel[label]{
    resource := input[_]
    resource.Type == "resource"
    resource.Labels[_] == "aws_route53_zone"
    label := concat(".", resource.Labels)
}

isRouteQueryLogValid{
    resource := input[_]
    resource.Type == "resource"
    resource.Labels[_] == "aws_route53_query_log"
    contains(resource.Attributes.zone_id, getRouteZoneLabel[_])
}

pass[resource]{
    resource := input[_]
	isvalid(resource)
    isRouteQueryLogValid
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "Domain Name System (DNS) query logging is enabled for Amazon Route 53 hosted zones.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "Domain Name System (DNS) query logging should be enable for Amazon Route 53 hosted zones.",
                "snippet": block }
} 