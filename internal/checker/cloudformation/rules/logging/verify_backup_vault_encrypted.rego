# METADATA
# title: "Verify Backup Vault is encrypted using KMS CMK"
# description: "This policy ensures that encrypting your data with KMS safeguards it against unauthorized access or tampering, protecting it both in storage and transit. It mitigates risks from external threats like hackers and malware, as well as internal ones such as accidental or unauthorized access."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-backup-backupvault.html
# custom:
#   id: CB_CFT_105
#   severity: MEDIUM
package lib.cloudformation.CB_CFT_105
import future.keywords.in

resource := "AWS::Backup::BackupVault"

is_valid {
	some resources in input.Resources
	resources.Type == resource
}

pass[properties] {
    some resource in input.Resources
    properties := resource.Properties
   "EncryptionKeyArn" in object.keys(properties)
    properties.EncryptionKeyArn != ""
}

fail[resources] {
    resources := input.Resources
    is_valid
    count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "Backup Vault is encrypted using KMS CMK",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Backup Vault is not encrypted using KMS CMK",
		"snippet": block,
	}
}