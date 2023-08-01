# METADATA
# title: "Verify Secrets Manager secrets should be rotated within 90 days"
# description: "Verifying that Secrets Manager secrets are rotated within 90 days ensures data security by regularly refreshing sensitive information, reducing the impact of potential breaches and aligning with compliance standards."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_rotation
# custom:
#   id: CB_TFAWS_285
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_285

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_secretsmanager_secret_rotation"
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
    resource.Blocks[_].Type == "rotation_rules"
    days := to_number(resource.Blocks[_].Attributes.automatically_after_days)
    days <= 90
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "Secrets Manager secrets rotations is set properly.",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "Secrets Manager secrets should be rotated within 90 days.",
                "snippet": block }
}
