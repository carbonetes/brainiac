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
import rego.v1

isvalid(block) if{
	block.Type == "resource"
    some label in block.Labels 
    label == "aws_acm_certificate"
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

fail contains block if {
	some block in input
	isvalid(block)
   	not pass[block]
}

pass contains resource if {
    some resource in input
	isvalid(resource)
    count(resource.Blocks) < 1
}

pass contains resource if {
    some resource in input
	isvalid(resource)
    some blocks in resource.Blocks
    blocks.Type != "options"
}

pass contains resource if {
    some resource in input
	isvalid(resource)
    some blocks in resource.Blocks
    blocks.Type == "options"
    not has_attribute(blocks.Attributes, "certificate_transparency_logging_preference")
}

pass contains resource if {
    some resource in input
	isvalid(resource)
    some blocks in resource.Blocks
    blocks.Type == "options"
    blocks.Attributes.certificate_transparency_logging_preference == "ENABLED"
}

passed contains result if {
    some block in pass
	result := { "message": "Logging preference for ACM certificates is enabled",
                "snippet": block}
}

failed contains result if {
    some block in fail
	result := { "message": "Logging preference for ACM certificates should be enabled",
                "snippet": block }
}
