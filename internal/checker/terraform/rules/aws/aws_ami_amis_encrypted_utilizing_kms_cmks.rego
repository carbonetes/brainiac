# METADATA
# title: "Verify that AMIs have encryption enabled using KMS Customer Managed Keys (CMKs)"
# description: "This policy aims to detect AMIs encrypted using default KMS keys rather than Customer Managed Keys (CMKs). Utilizing Customer Managed KMS Keys for encrypting EFS data is considered a best practice as it offers enhanced control and ownership over the encrypted data."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami
# custom:
#   id: CB_TFAWS_203
#   severity: LOW
package lib.terraform.CB_TFAWS_203

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_ami"
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

fail[resource]{
    resource := input[_]
	isvalid(resource)
    Block := resource.Blocks[_]
    Block.Type == "ebs_block_device"
    not has_attribute(Block.Attributes, "snapshot_id")
    resource.Blocks[_].Attributes.encrypted == false
}

fail[resource]{
    resource := input[_]
	isvalid(resource)
    Block := resource.Blocks[_]
    Block.Type == "ebs_block_device"
    not has_attribute(Block.Attributes, "snapshot_id")
    not has_attribute(Block.Attributes, "encrypted")
}

pass[resource] {
    resource := input[_]
    isvalid(resource)
    not fail[resource]
}

passed[result] {
	block := pass[_]
	result := { "message": "AMIs are utilizing KMS CMKs for encryption.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "AMIs must utilize KMS CMKs for encryption.",
                "snippet": block }
} 