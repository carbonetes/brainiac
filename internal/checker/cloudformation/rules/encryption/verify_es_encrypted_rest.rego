# METADATA
# title: "Verify that all information stored within Elasticsearch is securely encrypted while at rest."
# description: "To protect your data, this feature encrypts everything stored in your domain, including search indexes, logs, temporary files, applications, and even backups, using secure keys managed by AWS. It uses the industry-standard AES-256 encryption algorithm for this purpose."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-elasticsearch-domain.html
# custom:
#   id: CB_CFT_003
#   severity: LOW
package lib.cloudformation.CB_CFT_003

import future.keywords.in

resource := "AWS::Elasticsearch::Domain"

is_valid {
	some resources in input.Resources
	resources.Type == resource
}

pass[block] {
	is_valid
	some resources in input.Resources
	rest := resources.Properties.EncryptionAtRestOptions
	rest.Enabled == true
	block := rest
}

fail[resources] {
	resources := input.Resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "Encryption requirements are met for securing the Elasticsearch domain while data is at rest.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Encryption settings are necessary to ensure the security of the Elasticsearch domain when data is at rest.",
		"snippet": block,
	}
}
