# METADATA
# title: "Verify public facing ALB are protected by WAF"
# description: "By enforcing this policy, organizations can enhance the security posture of their web applications and services."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb.html
# custom:
#   id: CB_TFAWS_325
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_325

validResource := ["aws_alb", "aws_lb"]

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == validResource[_]
}

resource[resource] {
    block := pass[_]
	resource := concat(".", block.Labels)
} 

resource[resource] { 
    block := fail[_]
	resource := concat(".", block.Labels)
} 

getAlbLabel[label]{
    resource := input[_]
    resource.Type == "resource"
    resource.Labels[_] == validResource[_]
    label := concat(".", resource.Labels)
}

isAWSWAF_linked {
    resource := input[_]
    resource.Type == "resource"
    validWafResource := ["aws_wafregional_web_acl_association", "aws_wafv2_web_acl_association"]
    resource.Labels[_] == validWafResource[_]
    label := getAlbLabel[_]
    contains(resource.Attributes.resource_arn, label)
}

pass[resource]{
    resource := input[_]
	isvalid(resource)
    isAWSWAF_linked
}

pass[resource]{
    resource := input[_]
	isvalid(resource)
    validLb := ["network", "gateway"]
    resource.Attributes.load_balancer_type == validLb[_]
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "Public facing ALB are protected by WAF.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "Public facing ALB should be protected by WAF.",
                "snippet": block }
} 