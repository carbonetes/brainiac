# METADATA
# title: "Verify that Glacier Vault access policy is not public by only allowing specific services or principals to access it"
# description: "By implementing a restricted access policy for the Glacier Vault, only allowing specific services or principals to access it, we ensure that sensitive data stored within the vault remains secure and protected from unauthorized access."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/backup_vault
# custom:
#   id: CB_TFAWS_158
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_158

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_glacier_vault"
}

resource[resource] {
    block := pass[_]
	resource := concat(".", block.Labels)
} 

resource[resource] { 
    block := fail[_]
	resource := concat(".", block.Labels)
} 

pass[block] {
    block := input[_]
	isvalid(block)
   	not fail[block]
}

fail[resource] {
	resource := input[_]
    isvalid(resource)

    access_policy := json.unmarshal(resource.Attributes.access_policy).Statement[_]
    access_policy.Principal == "*"
    access_policy.Effect == "Allow"
}


passed[result] {
	block := pass[_]
	result := { "message": "'aws_glacier_vault' for 'access_policy' is set properly.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_glacier_vault' for 'access_policy' should be set.",
                "snippet": block }
} 