# METADATA
# title: "Verify CloudFront distributions should have origin failover configured"
# description: "Origin failover automatically switches to a backup origin if the primary one becomes unavailable, ensuring continuous content delivery during outages or disruptions."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution#origin_group
# custom:
#   id: CB_TFAWS_293
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_293

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_cloudfront_distribution"
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
    resource.Blocks[_].Type == "origin_group"
    resource.Blocks[_].Blocks[_].Type == "failover_criteria"
    count(count_member_types) > 1
}

count_member_types[member] {
    resource := input[_]
    resource.Blocks[_].Type == "origin_group"
    member := resource.Blocks[_].Blocks[_]
    member.Type == "member"
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "CloudFront distributions have origin failover configured.",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "CloudFront distributions should have origin failover configured.",
                "snippet": block }
}
