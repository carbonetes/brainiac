# METADATA
# title: "Verify that all Session Manager data is transmitted securely"
# description: "When working with critical production data, it is strongly advised to use encryption at rest to prevent unwanted access."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_document
# custom:
#   id: CB_TFAWS_087
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_087

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_ssm_document"
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
    contentStr := block.Attributes.content
    contentParsed := json.unmarshal(contentStr)
    not has_attribute(contentParsed.inputs, "kmsKeyId")
}



pass[block] {
    block := input[_]
	isvalid(block)
    not fail[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "Session Manager data is transmitted securely.",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "Session Manager data should be transmitted securely.",
                "snippet": block}
}
