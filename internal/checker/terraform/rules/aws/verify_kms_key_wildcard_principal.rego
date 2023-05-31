# METADATA
# title: "Verify KMS key policy does not have wildcard principal"
# description: "This check verifies whether the KMS key policy contains wildcard (*) principals, which is important for restricting access, adhering to the principle of least privilege, and preventing unauthorized use or misuse of cryptographic keys."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key#policy
# custom:
#   id: CB_TFAWS_066
#   severity: HIGH
package lib.terraform.CB_TFAWS_030

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_kms_key"
}

has_attribute(key, value) {
  _ = key[value]
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

fail[resource]{
    resource := input[_]
	isvalid(resource)
    has_attribute(resource.Attributes, "policy")
    statement := json.unmarshal(resource.Attributes.policy).Statement[0]
    statement.Effect == "Allow"
    statement.Principal.AWS == "*"
}

fail[resource]{
    resource := input[_]
	isvalid(resource)
    has_attribute(resource.Attributes, "policy")
    statement := json.unmarshal(resource.Attributes.policy).Statement[0]
    statement.Effect == "Allow"
    statement.Principal.AWS[_] == "*"
}

passed[result] {
	block := pass[_]
	result := { "message": "'aws_kms_key' 'policy' is set properly.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_kms_key' 'policy' is not set properly.",
                "snippet": block }
} 