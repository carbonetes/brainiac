# METADATA
# title: "Verify that rotation for customer-created CMKs is enabled."
# description: "This policy ensures cryptographic operations like encryption and decryption can continue seamlessly. Automated rotation preserves all previous keys, facilitating transparent decryption of encrypted data."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-kms-key.html
# custom:
#   id: CB_CFT_005
#   severity: MEDIUM
package lib.cloudformation.CB_CFT_005
import future.keywords.in

resource := "AWS::KMS::Key"    

is_valid {
    some resources in input.Resources
    resources.Type == resource
}

pass[block] {
    is_valid
    some resources in input.Resources
    resources.Type == resource
    block :=  resources.Properties.EnableKeyRotation
	block = true
}


fail[resources] {
    resources := input.Resources
    is_valid
    count(pass) == 0
}

passed[result] {
    some block in pass
    result := {
        "message": "Key rotation is enabled for customer-created CMKs, meeting encryption requirements.",
        "snippet": block,
    }
}

failed[result] {
    some block in fail
    result := {
        "message": "Key rotation must be enabled for customer-created CMKs to meet encryption requirements.",
        "snippet": block,
    }
}
