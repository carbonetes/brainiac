# METADATA
# title: "Verify that the provider has no hard-coded AWS access keys or secret keys"
# description: "Avoid storing hardcoded keys and secrets in infrastructure code or version-controlled configuration settings."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs
# custom:
#   id: CB_TFAWS_054
#   severity: CRITICAL
package lib.terraform.CB_TFAWS_054

isvalid(block){
	block.Type == "provider"
    block.Labels[_] == "aws"
}

resource [resource]{
    block := pass[_]
	resource := concat(".", block.Labels)
} 
resource [resource]{
    block := fail[_]
	resource := concat(".", block.Labels)
} 

checkRegex(block){
	regex.match("[A-Z0-9]{20}", block.Attributes.access_key)

}

checkRegex(block){
	regex.match("[a-zA-Z0-9/+]{40}", block.Attributes.secret_key)
}

fail[resource] {
	resource := input[_]
	isvalid(resource)
    checkRegex(resource)
}

pass[resource] {
	resource := input[_]
	isvalid(resource)
	not fail[resource]
}

passed[result] {
	block := pass[_]
	result := { "message": "Hard-coded AWS access keys or secret keys not found.",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "Do not include hard-coded AWS access keys or secret keys.",
                "snippet": block }
}













