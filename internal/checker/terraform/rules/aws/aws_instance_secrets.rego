# METADATA
# title: "Verify that EC2 user data doesn't contain any hard-coded secrets"
# description: "Removing secrets from unencrypted locations reduces the risk of exposing sensitive information to unauthorized parties."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance
# custom:
#   id: CB_TFAWS_048
#   severity: HIGH
package lib.terraform.CB_TFAWS_048

import future.keywords.in 


isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_instance"
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
    block.Type == "resource"
    user_data := block.Attributes.user_data
    key := ["access_key", "secret_key"]
    contains(user_data, key[_])
}


pass[block] {
    block := input[_]
	isvalid(block)
    not fail[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "No secrets found in EC2 user data.",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "Secrets should not exist in an EC2 user data.",
                "snippet": block}
}
