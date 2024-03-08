# METADATA
# title: "Verify encryption is enabled in Glue Data Catalog"
# description: "Ensure encryption is enabled in the AWS Glue Data Catalog to enhance data security and compliance."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-glue-datacatalogencryptionsettings.html
# custom:
#   id: CB_CFT_074
#   severity: HIGH
package lib.cloudformation.CB_CFT_074
import future.keywords.in

resource := "AWS::Glue::DataCatalogEncryptionSettings"

is_valid {
	some resources in input.Resources
	resources.Type == resource
}

pass[properties] {
    is_valid
    some resources in input.Resources
    properties := resources.Properties.DataCatalogEncryptionSettings
    properties.ConnectionPasswordEncryption.ReturnConnectionPasswordEncrypted == true
    properties.EncryptionAtRest.CatalogEncryptionMode == "ENABLED"
}

fail[resources] {
	resources := input.Resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some properties in pass
	result := {
		"message": "Glue Data Catalog encryption enabled",
		"snippet": properties,
	}
}

failed[result] {
	some properties in fail
	result := {
		"message": "Glue Data Catalog encryption disabled",
		"snippet": properties,
	}
}
