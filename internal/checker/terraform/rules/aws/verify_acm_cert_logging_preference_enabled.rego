# METADATA
# title: "Verify that logging preference for ACM certificates is enabled"
# description: "By enabling certificate transparency logging for ACM certificates, organizations can enhance the security and trustworthiness of their SSL/TLS certificates by ensuring their issuance and existence are publicly logged, promoting transparency and mitigating the risk of unauthorized or malicious certificate use."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate
# custom:
#   id: CB_TFAWS_222
#   severity: LOW
package lib.terraform.CB_TFAWS_222

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_acm_certificate"
}

has_attribute(key, value) {
  _ = key[value]
}

resource [resource]{
    block := pass[_]
	resource := concat(".", block.Labels)
} 
resource [resource]{
    block := fail[_]
	resource := concat(".", block.Labels)
} 

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

pass[resource] {
    resource := input[_]
	isvalid(resource)
    count(resource.Blocks) < 1
}

pass[resource] {
    resource := input[_]
	isvalid(resource)
    blocks := resource.Blocks[_]
    blocks.Type != "options"
}

pass[resource] {
    resource := input[_]
	isvalid(resource)
    blocks := resource.Blocks[_]
    blocks.Type == "options"
    not has_attribute(blocks.Attributes, "certificate_transparency_logging_preference")
}

pass[resource] {
    resource := input[_]
	isvalid(resource)
    blocks := resource.Blocks[_]
    blocks.Type == "options"
    blocks.Attributes.certificate_transparency_logging_preference == "ENABLED"
}

passed[result] {
	block := pass[_]
	result := { "message": "Logging preference for ACM certificates is enabled",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "Logging preference for ACM certificates should be enabled",
                "snippet": block }
}
