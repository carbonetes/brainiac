# METADATA
# title: "Verify Create before destroy for ACM certificates is enabled"
# description: "By utilizing the `create_before_destroy` lifecycle configuration in Terraform for ACM certificates, you ensure a seamless transition by creating the new certificate before removing the old one, maintaining uninterrupted secure communication for your domain."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate
# custom:
#   id: CB_TFAWS_221
#   severity: LOW
package lib.terraform.CB_TFAWS_221
import rego.v1

isvalid(block) if{
	block.Type == "resource"
    some label in block.Labels 
    label == "aws_acm_certificate"
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
    some blocks in resource.Blocks
    blocks.Type == "lifecycle"
    blocks.Attributes.create_before_destroy == true
}

fail contains block if {
	some block in input
	isvalid(block)
   	not pass[block]
}

passed contains result if {
    some block in pass
	result := { "message": "Create before destroy for ACM certificates is enabled",
                "snippet": block}
}

failed contains result if {
    some block in fail
	result := { "message": "Create before destroy for ACM certificates should be enabled",
                "snippet": block }
}
