# METADATA
# title: "Verify CosmosDB does not allow privileged escalation by restricting management plane changes"
# description: "This policy aims to mitigate risk by restricting management plane alterations for clients employing key-based authentication. Typically, CosmosDB access keys are utilized by applications to access data within CosmosDB containers. Instances where these keys are employed to execute management changes are infrequent in organizational use cases."
# scope: package
# related_resources:
# - https://learn.microsoft.com/en-us/azure/templates/microsoft.documentdb/databaseaccounts?pivots=deployment-language-arm-template
# custom:
#   id: CB_AZR_072
#   severity:  LOW
package lib.azurearm.CB_AZR_072

import future.keywords.in

resource := "Microsoft.DocumentDB/databaseAccounts"

is_valid {
	some resources in input.resources
	resources.type == resource
}

pass[properties] {
	some resource in input.resources
	properties := resource.properties
	"disableKeyBasedMetadataWriteAccess" in object.keys(properties)
}

fail[resources] {
	resources := input.resources
	is_valid
	count(pass) == 0
}

passed[result] {
    some block in pass
    result := {
        "message": "CosmosDB does not allow privileged escalation by restricting management plane changes.",
        "snippet": block,
    }
}

failed[result] {
    some block in fail
    result := {
        "message": "CosmosDB allows privileged escalation by not restricting management plane changes.",
        "snippet": block,
    }
}
