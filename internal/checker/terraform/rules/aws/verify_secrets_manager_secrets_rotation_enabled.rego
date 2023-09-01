# METADATA
# title: "Verify Secrets Manager secrets should have automatic rotation enabled"
# description: "This prevents unauthorized access due to long-lived credentials. Automated rotation of secrets helps maintain compliance with security best practices and industry regulations."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_rotation
# custom:
#   id: CB_TFAWS_355
#   severity: HIGH
package lib.terraform.CB_TFAWS_355

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_secretsmanager_secret"
}

resource [resource]{
    block := pass[_]
	resource := concat(".", block.Labels)
} 
resource [resource]{
    block := fail[_]
	resource := concat(".", block.Labels)
} 
getSecretManagerLabel[label] {
    resource := input[_]
    resource.Type == "resource"
    resource.Labels[_] == "aws_secretsmanager_secret"
    label := concat(".", resource.Labels)
}

isRotationAttached{
    resource := input[_]
    resource.Type == "resource"
    resource.Labels[_] == "aws_secretsmanager_secret_rotation"
    label := getSecretManagerLabel[_]
    contains(resource.Attributes.secret_id, label)
}

pass[resource]{
    resource := input[_]
	isvalid(resource)
    isRotationAttached
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
	result := { "message": "Secrets Manager secrets should have automatic rotation enabled.",
                "snippet": block }
}
