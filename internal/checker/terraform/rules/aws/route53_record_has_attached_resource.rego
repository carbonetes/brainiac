# METADATA
# title: "Route53 A Record has Attached Resource"
# description: "This policy focuses on verifying that A records are linked to the intended resources, often using alias names, and adhere to predefined naming conventions."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record.html#attribute-reference
# custom:
#   id: CB_TFAWS_319
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_319

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_route53_record"
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
    resource.Attributes.type == "A"
    blocks := resource.Blocks[_]
    blocks.Type == "alias"
    validValues := ["module", "data.", "var."]
    contains(blocks.Attributes.name, validValues[_])
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "Route53 A Record has Attached Resource.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "Route53 A Record should have Attached Resource.",
                "snippet": block }
} 