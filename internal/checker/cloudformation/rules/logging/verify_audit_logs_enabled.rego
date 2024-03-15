# METADATA
# title: "Verify DocDB have audit logs enabled"
# description: "This policy enables monitoring and tracking of activities within your Amazon DocumentDB (DocDB) cluster. It provides detailed records of database actions, including accessed databases, operation types, and the identities of users or applications involved."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-docdb-dbclusterparametergroup.html
# custom:
#   id: CB_CFT_077
#   severity: LOW
package lib.cloudformation.CB_CFT_077
import future.keywords.in

resource := "AWS::DocDB::DBClusterParameterGroup"

is_valid {
	some resources in input.Resources
	resources.Type == resource
}

pass[properties] {
    is_valid
    some resources in input.Resources
    properties := resources.Properties
	parameters := properties.Parameters
    audit_value := ["enabled", true]
    parameters.audit_logs in audit_value
}

fail[resources] {
    resources := input.Resources
    is_valid
    count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "DocumentDB has audit logs enabled",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "DocumentDB has audit logs not enabled",
		"snippet": block,
	}
}
