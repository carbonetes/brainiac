# METADATA
# title: "Verify Storage logging is enabled for Queue service for read, write and delete requests"
# description: "This policy ensures that server-side Storage Logging is enabled, capturing details in the storage account for both successful and failed requests. These logs provide insight into read, write, and delete operations against the queues. They contain various details about individual requests, including timing information (such as start time and end-to-end latency), authentication details, concurrency information, and the sizes of request and response messages."
# scope: package
# related_resources:
# - https://learn.microsoft.com/en-us/azure/templates/microsoft.storage/storageaccounts/queueservices?pivots=deployment-language-arm-template
# custom:
#   id: CB_AZR_033
#   severity: MEDIUM
package lib.azurearm.CB_AZR_033

import future.keywords.in

resource := "Microsoft.Storage/storageAccounts/queueServices/providers/diagnosticsettings"

is_valid {
    some resources in input.resources
    resources.type == resource
}

pass[properties] {
    is_valid
    some resource in input.resources
    properties := resource.properties
    categories := {"StorageRead", "StorageWrite", "StorageDelete"}
    all_categories := {log.category | some log in properties.logs; log.enabled == "true"}
    categories == all_categories
}

fail[resources] {
    resources := input.resources
    is_valid
    count(pass) == 0
}

passed[result] {
    some block in pass
    result := {
        "message": "Storage logging is enabled for Queue service for read, write and delete requests.",
        "snippet": block,
    }
}

failed[result] {
    some block in fail
    result := {
        "message": "Storage logging is not enabled for Queue service for read, write and delete requests.",
        "snippet": block,
    }
}
