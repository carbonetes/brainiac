# METADATA
# title: "Verify Timestream DB are encrypted with KMS CMK"
# description: "This policy ensures heightened security by encrypting all data at rest in Timestream using AWS Key Management Service (AWS KMS). Employing a customer-managed key within KMS is recommended for greater control over key permissions and lifecycle, including automatic annual rotation."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-timestream-database.html
# custom:
#   id: CB_CFT_099
#   severity: HIGH
package lib.cloudformation.CB_CFT_099
import future.keywords.in

resource := "AWS::Timestream::Database"

is_valid {
	some resources in input.Resources
	resources.Type == resource
}

pass[properties] {
    some resource in input.Resources
    properties := resource.Properties
	"KmsKeyId" in object.keys(properties)
    properties.KmsKeyId != ""
}

fail[resources] {
    resources := input.Resources
    is_valid
    count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "Timestream database is encrypted with KMS CMK",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Timestream database is not encrypted with KMS CMK",
		"snippet": block,
	}
}