# METADATA
# title: "Verify that AMIs have encryption enabled using KMS Customer Managed Keys (CMKs)"
# description: "This policy aims to detect AMIs encrypted using default KMS keys rather than Customer Managed Keys. Utilizing Customer Managed KMS Keys for encrypting EFS data is considered a best practice as it offers enhanced control and ownership over the encrypted data."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami
# custom:
#   id: CB_TFAWS_203
#   severity: LOW
package lib.terraform.CB_TFAWS_203
import rego.v1

isvalid(block) if{
	block.Type == "resource"
    some label in block.Labels 
    label == "aws_ami"
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

fail contains resource if {
    some resource in input
	isvalid(resource)
    some block in resource.Blocks
    block.Type == "ebs_block_device"
    not has_attribute(block.Attributes, "snapshot_id")
    block.Attributes.encrypted == false
}

fail contains resource if {
    some resource in input
	isvalid(resource)
    some block in resource.Blocks
    block.Type == "ebs_block_device"
    not has_attribute(block.Attributes, "snapshot_id")
    not has_attribute(block.Attributes, "encrypted")
}

pass contains block if {
	some block in input
    isvalid(block)
    not fail[block]
}

passed contains result if {
    some block in pass
	result := { "message": "AMIs are utilizing KMS CMKs for encryption.",
                "snippet": block }
}

failed contains result if {
    some block in fail
	result := { "message": "AMIs must utilize KMS CMKs for encryption.",
                "snippet": block }
} 